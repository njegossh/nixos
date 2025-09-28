{ config, pkgs, ... } : let
	home = config.users.users.marko.home;
	sdkHome = "${home}/.local/share";
	androidHome = "${sdkHome}/android-sdk";
	flutterHome = "${sdkHome}/flutter-sdk";
in {
	environment.variables = {
		ANDROID_HOME = androidHome;
    JAVA_HOME = pkgs.openjdk17.home;
    FLUTTER_HOME = flutterHome;
		PATH = [ "$PATH" "${flutterHome}/bin/" ];
	};

	environment.systemPackages = with pkgs;[
    openjdk17 sdkmanager unzip
    gradle
	];

	programs.nix-ld.enable = true;
	programs.adb.enable = true;
}
