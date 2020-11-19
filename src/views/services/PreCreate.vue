<template>
  <gov-width-container>
    <vue-headful :title="`${appName} - Add Service`" />

    <gov-back-link :to="{ name: 'services-index' }">
      Back to support listings
    </gov-back-link>

    <gov-main-wrapper>
      <gov-grid-row>
        <gov-grid-column width="one-half">
          <gov-heading size="xl">Add a new Support listing Page</gov-heading>

          <gov-body>
            You’re about to add a service/club/activity/group/helpline/information/app/advice
            to {{appName}}. Here are some things you should know:
          </gov-body>

          <gov-list bullet>
            <li>
              You will be asked to provide information a customer would want to
              know about your support listing - make sure you have it to hand
            </li>
            <li>
              You can add as many support listings as you want - so please split your
              support listings into multiple pages as appropriate
            </li>
            <li>
              When you are finished your page will be sent to the admin team for
              approval
            </li>
          </gov-list>

          <gov-warning-text>
            This form will take about 25 minutes to complete. We cannot save
            your progress, so please make sure you have enough time.
          </gov-warning-text>

          <gov-button :to="{name: 'services-index'}">
            Back to support listings
          </gov-button><!--
          -->&nbsp;<!--
          --><gov-button :to="{ name: 'services-create' }">
            Continue
          </gov-button>
        </gov-grid-column>
      </gov-grid-row>
    </gov-main-wrapper>
  </gov-width-container>
</template>
