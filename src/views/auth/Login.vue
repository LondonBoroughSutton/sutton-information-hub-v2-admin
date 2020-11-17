<template>
  <gov-width-container>
    <vue-headful :title="`${appName} - Login`" />

    <a :href="homepageUrl" class="govuk-back-link">Back to homepage and search</a>
    <gov-main-wrapper>
      <gov-grid-row>
        <gov-grid-column width="two-thirds">

          <gov-heading size="xl">First time user? Please click to register and create an account</gov-heading>

          <template v-if="!validateRequest">
            <gov-body size="l">
              Already have an account? Click on login
            </gov-body>

            <gov-button :href="loginUrl">Login</gov-button>&nbsp;
            <gov-button :to="registerTo">Register</gov-button>

            <gov-body size="s">
              For security reasons, you will be automatically logged out after {{ sessionTimeout }} minutes.
            </gov-body>
          </template>

        </gov-grid-column>
      </gov-grid-row>
    </gov-main-wrapper>
  </gov-width-container>
</template>

<script>
import Auth from "@/classes/Auth";

export default {
  name: "Login",
  data() {
    return {
      accessToken:
        Auth.parseQueryString(window.location.href).access_token || null,
      expiresIn: Auth.parseQueryString(window.location.href).expires_in || null
    };
  },
  computed: {
    homepageUrl() {
      return process.env.VUE_APP_FRONTEND_URI;
    },
    loginUrl() {
      return Auth.authorizeUrl;
    },
    registerTo() {
      return { name: "register-index" };
    },
    validateRequest() {
      if (this.accessToken === null) {
        return false;
      }

      if (this.expiresIn === null) {
        return false;
      }

      return true;
    },
    sessionTimeout() {
      return process.env.VUE_APP_SESSION_TIMEOUT;
    }
  },
  methods: {
    async login() {
      await Auth.login(this.accessToken, this.expiresIn);
      this.$root.$emit("login");
      this.$router.push({ name: "dashboard" });
    }
  },
  created() {
    if (this.validateRequest) {
      this.login();
    }
  }
};
</script>
