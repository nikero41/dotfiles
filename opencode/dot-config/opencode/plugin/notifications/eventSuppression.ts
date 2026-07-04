const COMPLETE_SUPPRESSION_AFTER_ERROR_MS = 5_000;

export class EventSuppression {
	suppressUntil = new Map<string, number>();

	cleanup = (now: number) => {
		this.suppressUntil.forEach((expiresAt, sessionID) => {
			if (expiresAt <= now) this.suppressUntil.delete(sessionID);
		});
	};

	suppressNext = (sessionId: string, now: number) => {
		this.suppressUntil.set(
			sessionId,
			now + COMPLETE_SUPPRESSION_AFTER_ERROR_MS,
		);
	};

	shouldSuppress = (sessionID: string, now: number) => {
		const expiresAt = this.suppressUntil.get(sessionID);
		if (expiresAt) this.suppressUntil.delete(sessionID);
		return !!expiresAt && expiresAt > now;
	};
}
