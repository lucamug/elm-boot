{ pkgs }: {
    deps = [
        pkgs.busybox
        pkgs.killall
        pkgs.esbuild
        pkgs.elmPackages.elm
        pkgs.elmPackages.elm-json
        pkgs.elmPackages.elm-format
        pkgs.elmPackages.elm-test
        pkgs.elmPackages.elm-doc-preview
        pkgs.elmPackages.elm-language-server
        pkgs.nodejs-16_x
        pkgs.nodePackages.terser
        pkgs.nodePackages.npm-check-updates
        pkgs.nodePackages.html-minifier
        pkgs.yarn
        pkgs.cowsay
    ];
}