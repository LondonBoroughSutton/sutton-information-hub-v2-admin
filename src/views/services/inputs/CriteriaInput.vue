<template>
  <div>
    <gov-form-group :invalid="error" :id="id">
      <gov-fieldset-legend size="m">
        <gov-heading size="s">{{ label }}</gov-heading>
      </gov-fieldset-legend>
      <gov-body v-if="hint">{{ hint }}</gov-body>
      <gov-checkboxes>

        <gov-checkbox
        v-for="(option, index) in options"
        :key="`${id}_${index}_checkbox`"
          :value="value.includes(option)"
          @input="onInput(option, $event)"
          :id="`${id}_${index}_checkbox`"
          :name="option"
          :label="option"
          :disabled="isDisabled(option)"
        />


      </gov-checkboxes>

      <gov-error-message
          v-if="error"
          v-text="error"
          :for="id"
        />
    </gov-form-group>
  </div>
</template>

<script>
export default {
  name: "CriteriaInput",
  props: {
    value: {
      type: Array,
      required: true
    },
    options: {
      type: Array,
      required: true
    },
    error: {
      required: true
    },
    id: {
      type: String,
      required: true
    },
    label: {
      type: String,
      required: true
    },
    hint: {
      type: String,
      default: null
    },
    maxSelections: {
      type: Number,
      required: true
    }
  },
  methods: {
    onInput(field, value) {
      const values = this.value.slice();
      if (value) {
        if (!values.includes(field)) {
          values.push(field);
        }
      } else {
        if (values.includes(field)) {
          values.splice(values.indexOf(field), 1);
        }
      }
      this.$emit(`update:${this.id}`, values);
    },
    isDisabled(value) {
      return this.value.length >= 3 && !this.value.includes(value);
    }
  }
};
</script>
