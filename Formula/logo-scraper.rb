class LogoScraper < Formula
  desc "Download a Liquipedia tournament's event logo and every team's logos"
  homepage "https://github.com/drvnmgmt/ggn-asset-manager"
  url "git@github-source:drvnmgmt/ggn-asset-manager.git", branch: "main", using: :git
  version "1.0"

  depends_on "go" => :build

  def install
    cd "logo-scraper" do
      system "go", "build", *std_go_args(ldflags: "-s -w")
    end
  end

  def caveats
    <<~EOS
      Run with a Liquipedia tournament URL:
        logo-scraper https://liquipedia.net/counterstrike/BLAST/Rivals/2026/Fall

      By default logos are saved next to the program, which is inside Homebrew's
      Cellar, so pass an output folder:
        logo-scraper -out ~/Downloads/logos <url>
      Liquipedia's API terms ask for contact info in the User-Agent:
        export LIQUIPEDIA_USER_AGENT="GGN-Logo-Scraper/1.0 (you@example.com)"
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/logo-scraper -h 2>&1")
  end
end
