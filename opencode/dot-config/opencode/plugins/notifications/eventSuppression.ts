import { Clock, Context, Effect, HashMap, Layer, Option, Ref } from "effect";

const COMPLETE_SUPPRESSION_AFTER_ERROR_MS = 5000;

export class EventSuppress extends Context.Service<EventSuppress>()(
	"EventSuppression",
	{
		make: Effect.gen(function* () {
			const state = yield* Ref.make(HashMap.empty<string, number>());

			return {
				suppressNext: (sessionId: string) =>
					Effect.gen(function* () {
						const now = yield* Clock.currentTimeMillis;
						yield* Ref.update(state, state =>
							state.pipe(
								HashMap.filter(expiresAt => expiresAt > now),
								HashMap.set(
									sessionId,
									now + COMPLETE_SUPPRESSION_AFTER_ERROR_MS,
								),
							),
						);
					}),

				allowNotification: (sessionID: string) =>
					Effect.gen(function* () {
						const now = yield* Clock.currentTimeMillis;
						return yield* Ref.modify(state, state => [
							HashMap.get(state, sessionID).pipe(
								Option.map(expiresAt => expiresAt <= now),
								Option.getOrElse(() => true),
							),
							HashMap.remove(state, sessionID),
						]);
					}),
			};
		}),
	},
) {
	static readonly layer = Layer.effect(this, this.make);
}
