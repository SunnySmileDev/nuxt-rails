<template>
  <v-layout>
    <v-flex>
      <v-list>
        <v-list-tile v-for="post in posts" :key="post.id" :class="post.colour">
          <v-list>
            <h1> {{post.title}} </h1>
            <p> {{ post.content.slice(0, 50) + '...' }} 
                <NuxtLink :to="'posts/' + post.id"> more </NuxtLink>                
                <NuxtLink v-if="post.user_id == user_id || user_id == 1" :to="'posts/' + post.id + '/edit'"> edit </NuxtLink>
            </p>
          </v-list>
        </v-list-tile>
      </v-list>
      <v-btn nuxt :to="'posts/new/'"> New Post </v-btn>
    </v-flex>
  </v-layout>
</template>

<script>
import ActionCable from 'actioncable';
export default {
  // middleware: ['auth'],
  data () {
    return {
      posts: [],
      user_id: this.$auth.user.id,
      messageText: ""
    }
  },

  created() {
    const cable = ActionCable.createConsumer('ws://localhost:8080/cable ');
    this.messageChannel = cable.subscriptions.create( "PostStateChannel",{
      received: (data) => {
        this.loadPosts()
      },
    })
  },

  
  methods: {
    async loadPosts() {
      this.posts = await this.$axios.$get('/posts')
    },
  },
  mounted () {
    this.loadPosts()
  }
}
</script>
