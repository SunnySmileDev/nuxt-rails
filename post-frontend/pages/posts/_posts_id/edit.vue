<template>
  <v-layout>
    <v-flex>
      <v-card-text>
        <v-form>
          <v-text-field v-model="post.title" label="title" hint="*Required"/>
          <v-text-field v-model="post.content" label="content" hint="*Required"/>
        </v-form>
        <v-card-actions>
          <v-btn @click="update">Update</v-btn>
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
      post: {
        title: '',
        content: '',
        user_id: this.$auth.user.id
      },
      id: this.$route.params.posts_id,
    }
  },
  methods: {
    async loadDetailPost() {
      var result = await this.$axios.$get(`/posts/${this.id}`);
      this.post = result.post
      this.comments = result.comments  
    },
    update: function() {
      this.$axios.$put(`/posts/${this.id}`, this.post);
      this.$router.push('/posts')
    }
  },
  mounted () {
    this.loadDetailPost()
  }

}
</script>
