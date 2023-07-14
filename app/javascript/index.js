document.addEventListener('DOMContentLoaded', function() {
  let div = document.getElementById('payment')
  if (div === null) { return }

  stripe_public_key = document.querySelector('meta[name="stripe-public-key"]').getAttribute('content');
  stripe = Stripe(stripe_public_key)
  stripe.redirectToCheckout({
    sessionId: div.getAttribute('data-session-id')
  }).then(function (results) {

  })
})