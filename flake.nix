{
  description = "DJV's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Make sure to change any hard-coded paths if file directory changes
    nixosConfigurations = {
      void = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/void/configuration.nix
	  ./hosts/void/hardware-configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };

    # Future bare-metal configuration(s) go here
  };
}
