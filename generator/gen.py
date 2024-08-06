import hashlib
import json
import os
import urllib.request

def sha256sum(filename):
    with open(filename, 'rb', buffering=0) as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()


def generate_text(repo, version, sha256):
    return f'''class Xcresultparser@{version} < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/{repo}"
  version "{version}"
  url "https://github.com/{repo}/archive/{version}.tar.gz"
  sha256 "{sha256}"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{{prefix}}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{{bin}}/xcresultparser -o txt")
  end

end'''

def generate_versions(repo):

  url = f'https://api.github.com/repos/{repo}/releases'
  response = urllib.request.urlopen(url).read()
  response_object = json.loads(response)

  for release in response_object:
      if (release['prerelease']):
          continue

      print(f'Tag: {release['tag_name']}')
      version = release['tag_name']
      filename = f'{version}.tar.gz'
      file_url = f'https://github.com/{repo}/archive/{release['tag_name']}.tar.gz'
      print(f'\tfile_url: {file_url}')
      urllib.request.urlretrieve(file_url, filename)
      sha256 = sha256sum(filename)
      print(f'\tSHA256: {sha256}')

      with open(f'../xcresultparser@{version}.rb', "w") as text_file:
          text_file.write(generate_text(version, sha256))

generate_versions('a7ex/findsimulator')
generate_versions('a7ex/SBEnumerator')
generate_versions('a7ex/xcresultparser')
