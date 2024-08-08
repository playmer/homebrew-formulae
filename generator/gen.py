import hashlib
import json
import os
import urllib.request
from pathlib import Path

def sha256sum(filename):
    with open(filename, 'rb', buffering=0) as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()


def generate_text(user, repo, description, version, sha256, assert_string, command):
    return f'''class {repo.capitalize()}AT{version.replace(".", "")} < Formula
  desc "{description}"
  homepage "https://github.com/{user}/{repo}"
  version "{version}"
  url "https://github.com/{user}/{repo}/archive/{version}.tar.gz"
  sha256 "{sha256}"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{{prefix}}"
  end

  test do
    assert_match "{assert_string}", shell_output("{command}")
  end

end'''

def generate_formulae(user, repo, description, assert_string, command):
  url = f'https://api.github.com/repos/{user}/{repo}/releases'

  response = urllib.request.urlopen(url).read()
  response_object = json.loads(response)

  download_dir = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'downloads')
  Path(download_dir).mkdir(parents=True, exist_ok=True)

  for release in response_object:
      if (release['prerelease']):
          continue
      
      print(f'Tag: {release['tag_name']}')
      version = release['tag_name']

      # Undeniably a bit of a hack to generate version strings for findsimulator
      # but not sure how else to best match behavior here.
      if assert_string is None:
          numbers = version.split('.')
          if len(numbers) == 3:
              numbers = numbers[:-1]
          assert_string = '.'.join(numbers)

      filename = os.path.join(download_dir, f'{version}.tar.gz')
      file_url = f'https://github.com/{user}/{repo}/archive/{release['tag_name']}.tar.gz'
      print(f'\tfile_url: {file_url}')
      urllib.request.urlretrieve(file_url, filename)
      sha256 = sha256sum(filename)
      print(f'\tSHA256: {sha256}')

      with open(f'../{repo}@{version}.rb', "w") as text_file:
          text_file.write(generate_text(user, repo, description, version, sha256, assert_string, command))

generate_formulae(
    'a7ex', 
    'findsimulator', 
    "Compute 'destination' for xcodebuild command line tool to build Xcode projects.",
    None,
    '#{bin}/findsimulator -v'
    )

generate_formulae(
    'a7ex', 
    'SBEnumerator', 
    'Parse Xcode Interface Builder files and create enums for cell identifiers and accessibility identifiers',
    "Error: Argument error. No Interface Builder file was provided. Use --help for a usage description.",
    '#{bin}/sbenumerator'
    )

generate_formulae(
    'a7ex', 
    'xcresultparser', 
    'Parse .xcresult files and print summary in different formats',
    "Missing expected argument '<xcresult-file>'",
    '#{bin}/xcresultparser -o txt'
    )