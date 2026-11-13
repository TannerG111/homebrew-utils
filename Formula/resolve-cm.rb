class ResolveCm < Formula
  desc "DaVinci Resolve script: queue video links, download with yt-dlp, import to Media Pool"
  homepage "https://github.com/drvnmgmt/resolve-cm"
  url "git@github-source:drvnmgmt/resolve-cm.git", branch: "main", using: :git
  version "1.0"

  depends_on "ffmpeg"
  depends_on "yt-dlp"
  depends_on "deno"

  def install
    pkgshare.install "resolve-cm.lua"

    (bin/"resolve-cm-install").write <<~EOS
      #!/bin/bash
      set -e
      DEST="$HOME/Library/Application Support/Blackmagic Design/DaVinci Resolve/Fusion/Scripts/Utility"
      mkdir -p "$DEST"
      cp "#{pkgshare}/resolve-cm.lua" "$DEST/resolve-cm.lua"
      echo "Installed. In Resolve: Workspace > Scripts > resolve-cm"
    EOS
  end

  def caveats
    <<~EOS
      Copy the script into DaVinci Resolve's Utility scripts menu:
        resolve-cm-install
      Then in Resolve open Workspace > Scripts > resolve-cm.
      Re-run resolve-cm-install after each `brew upgrade resolve-cm`.
    EOS
  end

  test do
    assert_path_exists pkgshare/"resolve-cm.lua"
    assert_match "Utility", (bin/"resolve-cm-install").read
  end
end
