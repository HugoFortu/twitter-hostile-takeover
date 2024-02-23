<template>
  <EmojiPicker :native="true" @select="onSelectEmoji" />
  <v-file-input
      v-model="image"
      label="File input"
  ></v-file-input>
  {{ tweets }}
</template>

<script setup>
import { storeToRefs } from "pinia";
import { useAuthStore } from "~/store/auth";
import EmojiPicker from 'vue3-emoji-picker'
import 'vue3-emoji-picker/css'

const config = useRuntimeConfig();
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const image = ref(null)
const tweets = ref([])

const index = () => {
  $fetch(`${config.public.baseApiUrl}/tweets`, {
    credentials: "include",
  }).then((response) => {
    tweets.value = response
  })
}

const onSelectEmoji = (emoji) => {
  console.log(image.value);
  const formData = new FormData();
  formData.append( 'tweet[image]', image.value[0] );
  formData.append( 'tweet[user_id]', user.value.id);
  formData.append( 'tweet[content]', emoji.i);
  $fetch(`${config.public.baseApiUrl}/tweets`, {
    method: "POST",
    credentials: "include",
    body: formData
  }).then((response) => {

  })
}

onMounted(() => {
  index();
});

</script>