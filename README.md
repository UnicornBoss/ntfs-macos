Script automating NTFS volumes mount in read-write mode for MacOS via MacFUSE and NTFS-3G. Reference: https://github.com/osxfuse/osxfuse/wiki/NTFS-3G

Before running this script, make sure to install the following packages via Homebrew:
```bash
brew install --cask macfuse
brew install ntfs-3g-mac
```

Script execution:
```bash
./ntfs-mount.sh "My Volume Name"
```
