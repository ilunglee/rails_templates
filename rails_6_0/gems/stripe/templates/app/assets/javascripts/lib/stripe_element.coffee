class App.StripeElement

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      errorTarget: '.card-errors'
      activeKlass: 'process-card'
      styles:
        base:
          color: '#251C15'
          lineHeight: '18px'
          fontFamily: '"Helvetica Neue", Helvetica, sans-serif'
          fontSmoothing: 'antialiased'
          fontSize: '16px'
          '::placeholder': color: '#716B68'
        invalid:
          color: '#fa755a'
          iconColor: '#fa755a'
    }

    @options = $.extend defaults, @options
    @_bind()

  _bind: ->
    @configs      = @$element.data('configs')
    @options      = $.extend true, @options, @configs
    @form         = @$element.parents('form')[0]
    @$form        = $(@form)
    @$errorTarget = @$form.find(@options.errorTarget)

    # Create a Stripe client.
    stripe = Stripe($(document).find("[name='stripe_publishable_key']").attr('content'))
    # Create an instance of Elements.
    elements = stripe.elements()
    # Create an instance of the card Element.
    card = elements.create('card', style: @options.styles)
    # Add an instance of the card Element into the `card-element` <div>.
    card.mount "##{@$element.attr('id')}"
    # Handle real-time validation errors from the card Element.
    card.addEventListener 'change', (event) =>
      displayError = @$errorTarget
      if event.error
        displayError.textContent = event.error.message
      else
        displayError.textContent = ''
      if event.empty
        @$element.removeClass @options.activeKlass
      else
        @$element.addClass @options.activeKlass
      return
    # Handle form submission.
    @form.addEventListener 'submit', (e) =>
      return if @$element.is(':hidden') || !@$element.hasClass @options.activeKlass || @$element.attr('name') != 'commit'
      e.stopPropagation()
      e.preventDefault()
      stripe.createSource(card).then (result) =>
        if result.error
          # Inform the user if there was an error.
          @$errorTarget[0].textContent = result.error.message
          @$form.find('input[type="submit"]').removeAttr('disabled')
          return
        else
          # Send the token to your server.
          $(@$element.data('stripeToken')).val result.source.id
          @form.submit()
          return

$.widget.bridge 'appStripeElement', App.StripeElement
