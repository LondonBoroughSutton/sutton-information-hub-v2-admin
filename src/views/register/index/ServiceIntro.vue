<template>
  <div>
    <gov-back-link :to="{ name: 'register-index-organisation' }">
      Back
    </gov-back-link>

    <gov-main-wrapper>
      <gov-grid-row>
        <gov-grid-column width="two-thirds">
          <gov-heading size="l">
            Step 3: Advice on adding your first support listing
          </gov-heading>
          <gov-body>You are now able to add your first support listing – viewable by the public. </gov-body>
          <gov-body>Start by adding the priority information marked in red.</gov-body>
          <gov-list :bullet="true">
            <li>Keep your descriptions brief and specific, so they can fit within the summary box on the home page and bring to life what help is on offer and what this means for the busy member of the public who is scanning your listing quickly </li>
            <li>Use the drop-down menu options to better describe the type of support (e.g. app, help line etc) and the more specific support you offer (e.g. physiotherapy or debt advice) amongst other fields. Adding this extra level of detail means that we’ll make a much better match between your support and users needs.</li>
            <li>Don’t forget to click save &amp; submit, otherwise all of the data you’ve entered will be lost</li>
          </gov-list>
          <gov-body>For more <gov-link href="https://connect.nhs.uk/providers">detailed advice see here</gov-link></gov-body>
          <gov-body>Ready to create your first listing?</gov-body>
          <gov-button start :to="{ name: 'register-index-service' }">
            Confirm
          </gov-button>
        </gov-grid-column>
      </gov-grid-row>
    </gov-main-wrapper>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
</style>
