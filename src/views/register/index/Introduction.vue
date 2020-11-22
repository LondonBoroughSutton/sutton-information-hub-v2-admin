<template>
  <div>
    <a :href="homepageUrl" class="govuk-back-link">Back to homepage and search</a>

    <gov-main-wrapper>
      <gov-grid-row>
        <gov-grid-column width="two-thirds">
          <gov-heading size="l">
            Getting started with Connect is easy and involves 3 main steps
          </gov-heading>

          <gov-list type="ordered">
            <li>Step 1: add your name, email address and a password to create an account</li>
            <li>Step 2: add your organisation’s details</li>
            <li>Step 3: add your first support listing</li>
          </gov-list>

          <gov-body>
            The whole process should take around 10 minutes.
          </gov-body>
          <gov-body>
            As a minimum, complete the fields marked in red. You can always come back and refine your listings over time
          </gov-body>
          <gov-body>
            To complete the process you’ll need your organisation’s contact details plus details of one support offer (what is it, where is it, who it is for).
          </gov-body>
          <gov-body>
            Ready to start?
          </gov-body>

          <gov-button
            start
            :to="{ name: 'register-index-user' }"
          >
            Confirm
          </gov-button>
        </gov-grid-column>
      </gov-grid-row>
    </gov-main-wrapper>
  </div>
</template>

<script>
import GovBody from '../../../components/Gov/GovBody.vue';
export default {
  components: { GovBody },

  computed: {
    homepageUrl() {
      return process.env.VUE_APP_FRONTEND_URI;
    },
  },
};
</script>

<style lang="scss" scoped>
</style>
