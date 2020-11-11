<template>
    <gov-width-container>
        <vue-headful :title="`${appName} - Import Users`" />

        <gov-back-link :to="{ name: 'dashboard' }">Back to dashboard</gov-back-link>
        <gov-main-wrapper>
        <gov-grid-row>
            <gov-grid-column width="full">

                <gov-heading size="xl">Bulk upload users</gov-heading>
                <gov-body>
                    <p>This tool allows you to upload the details of more than one user into the platform. You can add up to 5000 users in a single document.</p>

                    <p>The import tool requires all documents to be either in the .xls or .xlsx format. Please note that .csv files are not supported.</p>

                    <p><gov-link :href="exampleSpreadsheetDownloadLink">An example template can be downloaded here</gov-link> for you to populate offline and upload below. The uploaded document must follow this template and new columns can not be added.</p>

                    <p>Upon import, the tool will check the data you have provided to make sure it is valid. If there are any errors with the data, none of the data will be imported and you will be informed of the specific rows and data that are invalid.</p>
                </gov-body>

                <user-roles-input
                  :roles="form.roles"
                  @input="form.roles = $event"
                  @clear="clearError($event)"
                  :errors="form.$errors"
                />

                <local-authority-select
                  :local_authority_id.sync="form.local_authority_id"
                  @clear="clearError($event)"
                  :errors="form.$errors"
                />

                <spreadsheet-import-form
                    :spreadsheet.sync="form.spreadsheet"
                    @clear="clearError($event)"
                    :feedback="formResponse"
                    :errors="form.$errors"
                />

                <gov-button v-if="form.$submitting" disabled type="submit">Uploading...</gov-button>
                <gov-button v-else @click="onSubmit" type="submit">Upload</gov-button>
                <ck-submit-error v-if="form.$errors.any()" />
            </gov-grid-column>
            </gov-grid-row>
            <gov-grid-row v-if="invalidRows.length">
              <gov-grid-column width="full">
                <spreadsheet-import-errors
                  :fields="fields"
                  :invalidRows="invalidRows"
                />
              </gov-grid-column>
            </gov-grid-row>
        </gov-main-wrapper>
    </gov-width-container>
</template>
<script>
import LocalAuthoritySelect from "@/views/users/inputs/LocalAuthoritySelect";
import UserRolesInput from "@/views/users/inputs/UserRolesInput";
import Form from "@/classes/Form";
import SpreadsheetImportForm from "@/components/SpreadsheetImportForm";
import SpreadsheetImportErrors from "@/components/SpreadsheetImportErrors";

export default {
  name: "UsersImport",
  components: {
    LocalAuthoritySelect,
    UserRolesInput,
    Form,
    SpreadsheetImportForm,
    SpreadsheetImportErrors
  },

  data() {
    return {
      uploadRows: null,

      invalidRows: [],

      form: new Form({
        roles: [],
        local_authority_id: null,
        spreadsheet: null
      }),

      fields: {
        index: "Index",
        first_name: "First Name",
        last_name: "Last Name",
        email: "Email",
        phone: "Phone",
        employer_name: "Employers Name",
        address_line_1: "Address 1",
        address_line_2: "Address 2",
        address_line_3: "Address 3",
        city: "City",
        county: "County",
        postcode: "Postcode",
        country: "Country"
      }
    };
  },

  computed: {
    formResponse() {
      return this.uploadRows
        ? "Imported " +
            this.uploadRows +
            (this.uploadRows === 1 ? " User" : " Users")
        : null;
    },
    exampleSpreadsheetDownloadLink() {
      return `${
        process.env.VUE_APP_API_URI
      }/downloads/users_import_example.xls`;
    }
  },

  methods: {
    resetForm() {
      this.form = new Form({
        roles: [],
        local_authority_id: null,
        spreadsheet: null
      });
    },
    clearError(event) {
      this.form.$errors.clear(event);
      this.uploadRows = null;
    },
    async onSubmit() {
      this.uploadRows = null;
      this.invalidRows = [];
      this.form
        .post("/users/import")
        .then(response => {
          this.uploadRows = response.data.imported_row_count;
          this.resetForm();
        })
        .catch(error => {
          if (error.data) {
            this.invalidRows = error.data.errors.spreadsheet;
            this.file = null;
          } else if (error.request) {
            console.error(error.request);
          } else {
            console.error(error.message);
          }
        });
    }
  }
};
</script>

<style lang="scss" scoped>
</style>
