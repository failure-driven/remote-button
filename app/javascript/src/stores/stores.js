import { writable } from "svelte/store";

// export const data = writable(0);

export const data = writable({
  readyState: 0,
  clientReflexMs: 0,
});
