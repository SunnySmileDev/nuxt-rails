import { mount } from '@vue/test-utils'
import Post from '@/pages/posts/index.vue'

const authMock = {
    loggedIn: true,
    user: {
        id: 1,
        email: "aaa@gmail.com"
    }
};

describe('Post', () => {
  test('is a Vue instance', () => {
    const wrapper = mount(Post, {
        mocks: {
          $auth: authMock
        }
      })
    expect(wrapper.vm).toBeTruthy()
  })
})
