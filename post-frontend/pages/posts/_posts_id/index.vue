<template>
  <v-layout>
    <v-flex>
      <v-list>
        <h1> {{ post.title }} </h1>
        <h3> {{ post.content }} </h3>
        <h5> {{post.user}} </h5>
      </v-list>
      <hr>
      <B>Comments:</B>
      <v-card-text>
        <v-form>
          <v-text-field v-model="content" label="Please add the comments" />
        </v-form>
        <v-card-actions>
          <v-btn @click="add">Comment</v-btn>
        </v-card-actions>
      </v-card-text>
      <v-list-tile v-for="c in comments" :key="c.id">
        <v-list>
          <p> {{ c.content}} </p>
        </v-list>
      </v-list-tile>
      
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  middleware: ['auth'],
  data () {
    return {
      post: {},
      comments: [],
      content: '',
      id: this.$route.params.posts_id,
      user_id: this.$auth.user.id
    }
  },
  methods: {
    async loadDetailPost() {
      var result = await this.$axios.$get(`/posts/${this.id}`);
      this.post = result.post
      this.comments = result.comments  
    },
    add: function() {
      this.$axios.$post('/comments', {
        post_id: this.post.id, 
        content: this.content,
        user_id: this.user_id
      })
      this.loadDetailPost()
    }
  },
  mounted () {
    this.loadDetailPost()
  }
}
</script>
