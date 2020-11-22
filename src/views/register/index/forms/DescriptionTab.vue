<template>
  <div>
    <gov-heading size="l">Short and longer description of your support offer</gov-heading>
    <gov-grid-row>
      <gov-grid-column width="one-half">

        <gov-body>
          These sections should describe what your {{ service.type }} offers and
          is the main body of content on your page on {{appName}}.
        </gov-body>

        <gov-section-break size="l" />

        <ck-textarea-input
          :value="service.intro"
          @input="$emit('input', { field: 'intro', value: $event })"
          id="intro"
          :label="`Your ${service.type}, an overview`"
          :hint="`Write a brief description of what your ${service.type} does.`"
          :maxlength="300"
          :error="errors.get('service.intro')"
        />

        <ck-wysiwyg-input
          :value="service.description"
          @input="$emit('input', { field: 'description', value: $event })"
          id="description"
          label="Long description"
          hint="This is the information that people will see when they have clicked on your summary page and want to know more. A good description will make sure that the right people come your way."
          :error="errors.get('service.description')"
          large
          :maxlength="1600"
        />

        <slot />
      </gov-grid-column>
    </gov-grid-row>
  </div>
</template>

<script>
import CkOfferingsInput from "@/views/services/inputs/OfferingsInput.vue";

export default {
  components: {
    CkOfferingsInput
  },

  props: {
    service: {
      type: Object,
      required: true
    },

    errors: {
      type: Object,
      required: true
    }
  }
};
</script>
