<template>
  <gov-form-group :invalid="error !== null">

      <gov-label :for="id" class="govuk-!-font-weight-bold">
        <slot name="label">{{ label }}</slot>
      </gov-label>

      <slot name="hint">
        <gov-hint v-if="hint" :for="id" v-text="hint" />
      </slot>

        <multiselect
          :id="id"
          :value="value"
          :options="options"
          placeholder="Please Select"
          label="text"
          track-by="value"
          class="govuk-select"
          :disabled="disabled"
          @select="onSelect($event)">
          </multiselect>

      <slot name="after-input" />

      <gov-error-message
        v-if="error !== null"
        v-text="error"
        :for="id"
      />

  </gov-form-group>
</template>

<script>
import Multiselect from 'vue-multiselect';

export default {
  components: {
    Multiselect,
  },
  props: {
    id: {
      required: true,
      type: String,
    },
    value: {
      required: true,
    },
    label: {
      required: true,
      type: String,
    },
    hint: {
      required: false,
      type: String,
    },
    error: {
      required: true,
    },
    options: {
      required: false,
      type: Array,
    },
    disabled: {
      required: false,
      type: Boolean,
      default: false,
    },
  },
  methods: {
    onSelect(selected) {
      this.$emit('input', selected);
    },
  },
};
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css">
</style>

<style lang="scss" scoped>
.govuk-select.multiselect {
  height: auto;
}
.govuk-select .multiselect__select {
  width: 20px;
  padding-left: 4px;
  padding-right: 4px;
  top: 0;
  height: 52px;
}
.govuk-select .multiselect__tags {
  border-color: transparent;
  padding-right: 20px;
}
</style>
