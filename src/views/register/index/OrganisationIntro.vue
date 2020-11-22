<template>
  <div>
    <gov-back-link :to="{ name: 'register-index-user' }">
      Back
    </gov-back-link>

    <gov-main-wrapper>
      <gov-grid-row>
        <gov-grid-column width="two-thirds">
          <gov-heading size="l">
            Step 2: Add your organisation’s details
          </gov-heading>

          <gov-body>Your next step is to add your organisation’s details.</gov-body>
          <gov-body>The information here is used to help manage your account on Connect.</gov-body>
          <gov-body>Contact details in this section are kept private and can only be viewed by staff helping to manage the system - not the public or other organisations.  </gov-body>
          <gov-body>You’ll be able to add public contact information as you wish for different support listings, which are viewed by everyone.</gov-body>
          <gov-body>Please focus for now on the priority sections marked in red.</gov-body>
          <gov-button start :to="{ name: 'register-index-organisation' }">
            Continue
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
