<script>
  export let dataset;
  const { config: { title } } = dataset;
</script>

<style>
  h1 {
    color: #FF3E00;
  }
</style>

<h1>{title}!</h1>
<div data-testid="demo-button">
  <div class="active" data-testid="mode-reflex">reflex</div>
  <div data-testid="mode-timer">timer</div>
  <div data-testid="mode-counter">counter</div>
  <button class="btn btn-primary" >button</button>
  <div data-testid="message">reflex test started</div>
</div>