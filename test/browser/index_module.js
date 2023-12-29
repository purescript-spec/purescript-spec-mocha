import { main } from "../../output/test_module.js";

mocha.setup("bdd");
main();
mocha.run();
