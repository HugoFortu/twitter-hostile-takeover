<template>
  <v-container>
    <v-row>
      <v-col>
      <NewTweet
      @refresh="index"
      />
      </v-col>
    </v-row>
    <v-row>
        <v-col>
          <v-infinite-scroll :items="tweets" :onLoad="load">
            <tweetList
              :tweets="tweets"
              @index="index"
            />
          </v-infinite-scroll>
        </v-col>
      </v-row>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { storeToRefs } from "pinia";
import { useAuthStore } from "~/store/auth";
import NewTweet from "~/components/tweets/New.vue";
import tweetList from "~/components/tweets/List.vue";

const config = useRuntimeConfig();
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const tweets = ref([])
const newTweets = ref([])
const page = ref(1)
const totalPages = ref(0)
const index = () => {
  $fetch(`${config.public.baseApiUrl}/tweets`, {
    credentials: "include",
    params: {
      page: 1,
    }
  }).then((response) => {
    tweets.value = response.data
    totalPages.value = response.total
  })
}

const load = async ({ done }) => {
  if (page.value === totalPages.value) {
    return done('empty')
  } else {
    page.value += 1
    await $fetch(`${config.public.baseApiUrl}/tweets`, {
      credentials: "include",
      params: {
        page: page.value,
      }
    }).then((response) => {
      newTweets.value = response.data
    })
    tweets.value.push(...newTweets.value)
    done('ok')
  }
}

onMounted(() => {
  index();
});
</script>
