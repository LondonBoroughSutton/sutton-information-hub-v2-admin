<template>
  <div>
    <gov-main-wrapper>
      <gov-grid-row>
        <gov-grid-column width="two-thirds">
          <gov-heading size="l">
            Congratulations, your first support listing is now live and can be viewed by the public!
          </gov-heading>

          <gov-body>
            You’re now part of the Connect family joining thousands of others who also created listings
          </gov-body>

          <gov-list :bullet="true">
            <li>Professionals such as GPs or Social Prescribing Link workers will match your support offer to people’s needs and wants.</li>
            <li>A wide range of funders will be able to see your listings and use intelligence collected by the Connect platform to make funding decisions in the future. </li>
            <li>Your support offers will also be pushed out via a range of channels including messaging systems used by public sector partners and social media.</li>
            <li>You can make this process work even better by sharing your new support listing on social media today.</li>
            <li>You will now be able to activate referrals on your listings – we recommend that so you both save time and have more control of how (and how many) new users come to you.</li>
            <li>And don’t forget to log into your account, add new support listings and keep the information you are presenting to the world uptodate and accurate.</li>
          </gov-list>

          <gov-button :to="{ name: 'dashboard' }" start>Home</gov-button>
        </gov-grid-column>
      </gov-grid-row>
    </gov-main-wrapper>
  </div>
</template>
