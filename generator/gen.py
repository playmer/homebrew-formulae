import hashlib
import json
import os
import urllib.request
from pathlib import Path

def sha256sum(filename):
    with open(filename, 'rb', buffering=0) as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()


def generate_text(user, repo, description, version, sha256, assert_string, command, is_latest_version):
    class_name = f'{repo.capitalize()}AT{version.replace(".", "")}'

    if (is_latest_version):
        class_name = repo.capitalize()

    return f'''class {class_name} < Formula
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

end
'''

def generate_version_list(url):
  print(url)
  response = urllib.request.urlopen(url).read()
  response_object = json.loads(response)

  versions_list = []

  for release in response_object:
      if (release['prerelease']):
          continue
      
      versions_list.append((release['tag_name'], release))

  versions_list = list(map(lambda s: ([int(u) for u in s[0].split('.')], s[1]), versions_list))
  versions_list.sort(reverse=True, key=lambda s: s[0])

  latest_minor_versions = [versions_list[0]]
  latest_major = versions_list[0][0][0]
  latest_minor = versions_list[0][0][1]

  for version in versions_list[1:]:
      major = version[0][0]
      minor = 0

      if (len(version[0]) > 1):
          minor = version[0][1]

      if ((major == latest_major) and (minor == latest_minor)):
          continue

      latest_minor_versions.append(version)
      latest_major = major
      latest_minor = minor

  return latest_minor_versions

def generate_formulae(user, repo, description, assert_string, command):
  base_dir = os.path.abspath(os.path.dirname(__file__))
  download_dir = os.path.join(base_dir, 'downloads')
  Path(download_dir).mkdir(parents=True, exist_ok=True)

  url = f'https://api.github.com/repos/{user}/{repo}/releases'
  is_latest_version = True

  for (version_list, release) in generate_version_list(url):
      if (release['prerelease']):
          continue
      
      print(f'Tag: {release['tag_name']}')
      version = release['tag_name']
      
      version_file_path = os.path.join(base_dir, f'../{repo.lower()}@{version}.rb')

      if os.path.isfile(version_file_path):
          continue

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

      with open(version_file_path, "w") as text_file:
          text_file.write(generate_text(user, repo, description, version, sha256, assert_string, command, False))

      if (is_latest_version):
          is_latest_version = False

          with open(os.path.join(base_dir, f'../{repo.lower()}.rb'), "w") as text_file:
              text_file.write(generate_text(user, repo, description, version, sha256, assert_string, command, True))

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