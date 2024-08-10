import hashlib
import json
import os
import urllib.request
from pathlib import Path

def sha256sum(filename):
    with open(filename, 'rb', buffering=0) as f:
        return hashlib.file_digest(f, 'sha256').hexdigest()


def generate_text(user, repo, description, version, sha256, testing_section, is_latest_version):
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

{testing_section}

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

def generate_formulae(user, repo, description, testing_section):
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

      filename = os.path.join(download_dir, f'{version}.tar.gz')
      file_url = f'https://github.com/{user}/{repo}/archive/{release['tag_name']}.tar.gz'
      print(f'\tfile_url: {file_url}')
      urllib.request.urlretrieve(file_url, filename)
      sha256 = sha256sum(filename)
      print(f'\tSHA256: {sha256}')

      with open(version_file_path, "w") as text_file:
          text_file.write(generate_text(user, repo, description, version, sha256, testing_section, False))

      if (is_latest_version):
          is_latest_version = False

          with open(os.path.join(base_dir, f'../{repo.lower()}.rb'), "w") as text_file:
              text_file.write(generate_text(user, repo, description, version, sha256, testing_section, True))

generate_formulae(
    'a7ex', 
    'findsimulator',
    "Compute 'destination' for xcodebuild command line tool to build Xcode projects.",
    '''  test do
    output = shell_output("#{bin}/findsimulator -h")
    assert output.start_with?("OVERVIEW: Interface to simctl in order to get suitable strings for destinations for the xcodebuild command."), "Expected output to start with 'OVERVIEW: Interface to simctl in order to get suitable strings for destinations for the xcodebuild command.', but got: #{output}"
  end'''
    )

generate_formulae(
    'a7ex', 
    'SBEnumerator',
    'Parse Xcode Interface Builder files and create enums for cell identifiers and accessibility identifiers',
    '''  test do
    assert_match "Error: Argument error. No Interface Builder file was provided. Use --help for a usage description.", shell_output("#{bin}/sbenumerator")
  end'''
    )

generate_formulae(
    'a7ex', 
    'xcresultparser',
    'Parse .xcresult files and print summary in different formats',
    '''  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end'''
    )