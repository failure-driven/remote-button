<script>
  import { onMount } from "svelte";
  import { getButton, pressButton } from "../services/button.js";

  export let demoButtonId;

  let ready = false;

  const changeReflexState = () => {
    pressButton({ buttonId: demoButtonId })
      .then(() => getButton({ buttonId: demoButtonId }))
      .then(() => (ready = !ready));
  };
</script>

<button
  on:click={changeReflexState}
  class={"btn " + (ready ? "btn-danger" : "btn-primary")}
  data-testid="button">button</button
>
<div data-testid="message">
  {!ready ? "almost time to boggie" : "reflex test started"}
</div>

<style></style>
