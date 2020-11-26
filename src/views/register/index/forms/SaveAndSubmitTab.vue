<template>
  <div>
    <gov-heading size="l">Are you ready to save and submit your support listing?</gov-heading>

    <gov-body>If you have entered all of the required information for your support offer, you can save and submit using the button below. This will add your support offer to the platform and it will be made live and will be viewable by the public.</gov-body>
    <gov-grid-row>
      <gov-grid-column width="one-half">
        <gov-button v-if="submitting" disabled type="submit">
                Submitting...
              </gov-button>

              <gov-button v-else @click="$emit('submit')" type="submit">
                Save &amp; Submit
              </gov-button>

              <ck-submit-error v-if="errors.any()">
                <strong>Check for errors</strong>
                <br><br>
                Errors may be on earlier sections of the form. You can navigate
                to these by clicking ‘Back’
              </ck-submit-error>
      </gov-grid-column>
    </gov-grid-row>
  </div>
</template>

<script>
export default {
  props: {
    submitting: {
      type: Boolean,
      default: false
    },

    errors: {
      type: Object,
      required: true
    }
  }
};
</script>

<style lang="scss" scoped>
</style>
