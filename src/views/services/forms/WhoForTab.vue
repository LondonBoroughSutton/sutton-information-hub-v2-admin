<template>
  <div>
    <gov-heading size="l">Who is your {{ type }} for?</gov-heading>
    <gov-grid-row>
      <gov-grid-column width="one-half">
        <gov-body>
          Only select options that are essential for describing the target audience (clicking more options will reduce your search prominence).
        </gov-body>
        <gov-section-break size="l" />

        <!-- Age group -->
        <criteria-input
          :value="age_group"
          :options="ageGroupOptions"
          :maxSelections="3"
          @update:age_group="$emit('update:age_group', $event); $emit('clear', 'criteria.age_group')"
          :error="errors.get('criteria.age_group')"
          id="age_group"
          label="Target age group (required)"
          hint="Select up to 3"
        />
        <!-- /Age group -->

        <!-- Disability -->
        <criteria-input
          :value="disability"
          :options="disabilityOptions"
          :maxSelections="3"
          @update:disability="$emit('update:disability', $event); $emit('clear', 'criteria.disability')"
          :error="errors.get('criteria.disability')"
          id="disability"
          label="Disabilities (if applicable)"
          hint="Select up to 3"
        />
        <!-- /Disability -->

        <!-- Gender -->
        <criteria-input
          :value="gender"
          :options="genderOptions"
          :maxSelections="3"
          @update:gender="$emit('update:gender', $event); $emit('clear', 'criteria.gender')"
          :error="errors.get('criteria.gender')"
          id="gender"
          label="Gender (if applicable)"
          hint="Select up to 3"
        />
        <!-- /Gender -->

        <!-- Benefits -->
        <criteria-input
          :value="benefits"
          :options="benefitOptions"
          :maxSelections="3"
          @update:benefits="$emit('update:benefits', $event); $emit('clear', 'criteria.benefits')"
          :error="errors.get('criteria.benefits')"
          id="benefits"
          label="Benefit Status (if applicable)"
          hint="Select up to 3"
        />
        <!-- /Benefits -->

        <!-- Employment -->
        <criteria-input
          :value="employment"
          :options="employmentOptions"
          :maxSelections="3"
          @update:employment="$emit('update:employment', $event); $emit('clear', 'criteria.employment')"
          :error="errors.get('criteria.employment')"
          id="employment"
          label="Employment Status (if applicable)"
          hint="Select up to 3"
        />
        <!-- /Employment -->

        <slot />

      </gov-grid-column>
    </gov-grid-row>
  </div>
</template>

<script>
import CriteriaInput from "@/views/services/inputs/CriteriaInput";

export default {
  name: "WhoForTab",
  components: { CriteriaInput },
  props: {
    errors: {
      required: true
    },
    type: {
      required: true,
      type: String
    },
    age_group: {
      required: true
    },
    disability: {
      required: true
    },
    employment: {
      required: true
    },
    gender: {
      required: true
    },
    benefits: {
      required: true
    }
  },
  data() {
    return {
      ageGroupOptions: [
        "Under 16",
        "16 to 24",
        "25 to 64",
        "65 to 84",
        "65 and over",
        "85 and over"
      ],
      disabilityOptions: [
        "Autistic",
        "Blind or partially sighted",
        "Deaf blind",
        "Learning disability",
        "Physically disabled",
        "Severely or profoundly deaf",
        "Wheelchair user",
        "Without speech"
      ],
      genderOptions: ["Female", "Male", "Non-binary", "Other", "Transgender"],
      benefitOptions: [
        "Housing Benefits and Council Tax Benefits",
        "Council Tax Benefits",
        "Council Tax Benefits only",
        "Employment and Support Allowance or incapacity benefit",
        "Housing Benefits",
        "Housing Benefits only",
        "Jobseeker's Allowance",
        "Lone Parent"
      ],
      employmentOptions: [
        "Employed full-time",
        "Employed part-time",
        "Full-time student",
        "In employment",
        "Long term sick or disabled",
        "Looking after home or family",
        "Not in employment",
        "Other",
        "Retired",
        "Self employed",
        "Severe long term sick or disabled",
        "Student (including full time students)"
      ]
    };
  }
};
</script>
