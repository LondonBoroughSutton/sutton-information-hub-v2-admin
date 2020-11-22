<template>
  <div>
    <gov-heading size="l">Short and longer description of your support offer</gov-heading>
    <gov-grid-row>
      <gov-grid-column width="one-half">

        <gov-body>
          These sections should describe what your {{ type }} offers and is the
          main body of content on your page on {{appName}}.
        </gov-body>

        <gov-section-break size="l" />

        <ck-textarea-input
          :value="intro"
          @input="$emit('update:intro', $event); $emit('clear', 'intro')"
          id="intro"
          :label="`Your ${type}, an overview?`"
          :hint="`Write a brief description of what your ${type} does.`"
          :maxlength="300"
          :error="errors.get('intro')"
        />

        <ck-wysiwyg-input
          :value="description"
          @input="$emit('update:description', $event); $emit('clear', 'description')"
          id="description"
          label="Long description"
          hint="This is the information that people will see when they have clicked on your summary page and want to know more. A good description will make sure that the right people come your way."
          :error="errors.get('description')"
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
  name: "DescriptionTab",
  components: {
    CkOfferingsInput
  },
  props: {
    errors: {
      required: true
    },
    type: {
      required: true,
      type: String
    },
    intro: {
      required: true
    },
    offerings: {
      required: true
    },
    description: {
      required: true
    }
  }
};
</script>
