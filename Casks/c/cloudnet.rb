cask "cloudnet" do
  version "1.36.2.2"
  sha256 "952d6d7ec0c83fa74d1e9c15f283bbd90a3118a1949ec3fa0f180ec6f453fbfc"

  url "https://pkgs.cloudnet.world/stable/macos/CloudNet_v#{version}.dmg"
  name "CloudNet for Mac client"
  desc "Enterprise-level meshVPN cloud service"
  homepage "https://cloudnet.world/"

  livecheck do
    url "https://pkgs.cloudnet.world/stable/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  app "CloudNet.app"
  installer script: {
    executable: "CloudNet.app/Contents/Resources/cnet",
    args:       ["install"],
    sudo:       true,
  }

  uninstall quit:      "world.cloudnet.client",
            launchctl: "world.cloudnet.client.cloudnetd",
            script:    {
              executable: "CloudNet.app/Contents/Resources/cnet",
              args:       ["uninstall"],
              sudo:       true,
            },
            delete:    [
              "/Applications/CloudNet.app",
              "/Library/LaunchDaemons/world.cloudnet.client.cloudnetd.plist",
            ]

  zap trash: [
    "~/Library/Containers/world.cloudnet.client",
    "~/Library/Group Containers/$(TeamIdentifierPrefix)world.cloudnet.client",
    "~/Library/Preferences/world.cloudnet.client.cloudnetd.plist",
  ]
end
