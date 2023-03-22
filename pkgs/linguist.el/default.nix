{lib , fetchFromGitHub , trivialBuild , emacs}:

trivialBuild {
  pname = "linguist";

  src = fetchFromGitHub {
    owner = "jeffkreeftmeijer";
    repo = "linguist.el";
    rev = "be1dd90fd8432a250806d6c130beedc487a34827";
    sha256 = "sha256-mzAzEmiVp2vACqCY3OGWCwYG4p9crHVFoaVaVUAwvro=";
  };
}
