import hashlib
import json
import os
import urllib.request

def sha256sum(filename):
    with open(filename, 'rb', buffering=0) as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()

url = 'https://api.github.com/repos/a7ex/xcresultparser/releases'

def generate_text(version, sha256):
    return f'''class Xcresultparser@{version} < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "{version}"
  url "https://github.com/a7ex/xcresultparser/archive/{version}.tar.gz"
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

#urllib.request.urlretrieve('https://github.com/a7ex/xcresultparser/archive/1.7.1.tar.gz', f'1.7.1.tar.gz')
#print(sha256sum("1.7.1.tar.gz"))
#exit()


response = urllib.request.urlopen(url).read()
response_object = json.loads(response)

for release in response_object:
    if (release['prerelease']):
        continue

    print(f'Tag: {release['tag_name']}')
    version = release['tag_name']
    filename = f'{version}.tar.gz'
    file_url = f'https://github.com/a7ex/xcresultparser/archive/{release['tag_name']}.tar.gz'
    print(f'\tfile_url: {file_url}')
    urllib.request.urlretrieve(file_url, filename)
    sha256 = sha256sum(filename)
    print(f'\tSHA256: {sha256}')

    with open(f'../xcresultparser@{version}.rb', "w") as text_file:
        text_file.write(generate_text(version, sha256))