<template>
  <div>
    <gov-checkbox
      v-for="node in filteredNodes"
      :class="{ 'govuk-checkboxes__item--nested': nested }"
      :key="node.id"
      :value="checked.includes(node.id)"
      @input="onUpdate({ node, enabled: $event })"
      :id="node.id"
      :name="node.id"
      :label="node.name"
      :disabled="disabled"
    >
      <slot :node="node"></slot>

      <ck-node-checkboxes
        v-if="node.children && node.children.length"
        :key="node.children[0].id"
        :nodes="node.children"
        :checked="checked"
        :filteredNodeIds="filteredNodeIds"
        :disabled="disabled"
        :nested="true"
        @update="onChildUpdate"
      >
        <template
          v-for="(_, name) in $scopedSlots"
          :slot="name"
          slot-scope="slotProps"
        >
          <slot :name="name" :node="slotProps.node"></slot>
        </template>
      </ck-node-checkboxes>
    </gov-checkbox>
  </div>
</template>

<script>
export default {
  name: 'CkNodeCheckboxes',
  props: {
    nodes: {
      required: true,
      type: Array,
    },
    checked: {
      required: true,
      type: Array,
    },
    filteredNodeIds: {
      type: [Array, Boolean],
      default() {
        return []
      },
    },
    disabled: {
      type: Boolean,
      default: false,
    },
    nested: {
      type: Boolean,
      default: false,
    },
  },

  computed: {
    filteredNodes() {
      if (Array.isArray(this.filteredNodeIds)) {
        return this.nodes.filter(node => this.filteredNodeIds.includes(node.id))
      }
      return this.filteredNodeIds ? this.nodes : []
    },
  },

  methods: {
    onUpdate({ node, enabled }) {
      this.$emit('update', { node, enabled })
    },
    onChildUpdate({ node, enabled }) {
      this.onUpdate({ node, enabled })
      if (node.parent_id) {
        const parent = this.nodes.find(n => n.id === node.parent_id)
        if (parent) {
          this.onUpdate({ node: parent, enabled })
        }
      }
    },
  },
}
</script>

<style lang="scss" scoped></style>
