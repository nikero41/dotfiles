import { Plugin } from "@opencode/plugin/effect";
import { Effect } from "effect";

export default Plugin.define({
	id: "nikero.notifications",
	effect: () => Effect.void,
});
