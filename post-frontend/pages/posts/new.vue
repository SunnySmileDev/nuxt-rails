<template>
  <v-layout>
    <v-flex>
        <v-card-text>
          <v-form>
            <v-text-field v-model="title" label="title" hint="*Required"/>
            <v-text-field v-model="content" label="content" hint="*Required"/>
          </v-form>
          <v-card-actions>
            <v-btn @click="create">Create</v-btn>
          </v-card-actions>
        </v-card-text>
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  middleware: ['auth'],
  data () {
    return {
      title: '',
      content: '',
      user_id: this.$auth.user.id
    }
  },
  methods: {
    create: function() {
      this.$axios.$post('/posts', {
        title: this.title,
        content: this.content,
        user_id: this.user_id,
      });
      this.$router.push('/posts')
    }
  },

}
</script>
