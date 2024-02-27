<template>
    <v-card class="mt-5 px-5 py-5 rounded">
      <v-row>
        <v-col
          cols="11"
          md="11">
          <v-card-title>
            Modifier un tweet
          </v-card-title>
        </v-col>
        <v-col
          cols="1"
          md="1"
        >
          <v-btn icon="mdi-close" density="compact" @click="emit('closeModal')"></v-btn>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-img :src="tweet.image_url" max-height="360px" class="mt-5"></v-img>
        </v-col>
      </v-row>
      <v-row>
        <v-col
          cols="11"
          md="11"
        >
          <v-text-field
            class="pl-5 field-disabled"
            clearable
            clear-icon="mdi-close-circle"
            label="Emojis"
            v-model="emojisText"
            disabled
          ></v-text-field>
        </v-col>
        <v-col
        cols="1"
        md="1"
        >
        <v-btn icon="mdi-close" density="compact" @click="clearEmojis"></v-btn>
        </v-col>

      </v-row>
      <v-row>
        <v-col
          cols="10"
          md="10"
        >
          <v-file-input
            clearable
            density="compact"
            v-model="imageFile"
            label="Modifier l'image"
          ></v-file-input>
        </v-col>
          <v-col
            cols="2"
            md="2"
            class="text-right"
          >
          <v-btn
            @click="displayEmojis"
            class="text-h5"
          >
          😆
          </v-btn>
          <v-dialog v-model="selectEmoji">
            <EmojiPicker :native="true" @select="onSelectEmoji" />
          </v-dialog>
        </v-col>
      </v-row>
      <v-row>
        <v-col
            cols="12"
            md="12"
            class="text-right"
          >
          <v-btn
            @click="sendTweet"
            :disabled="image === null && emojisText === ''"
          >
            Modifier
          </v-btn>
        </v-col>
      </v-row>
    </v-card>
</template>
<script setup>
import EmojiPicker from 'vue3-emoji-picker'
import { storeToRefs } from "pinia";
import { useAuthStore } from "~/store/auth";
import 'vue3-emoji-picker/css'

const emit = defineEmits();
const config = useRuntimeConfig();
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const selectEmoji = ref(false)
const props = defineProps({
  tweet: {
    type: Object,
    required: true
  }
})
const emojisText = ref(props.tweet.content)
const image = ref(props.tweet.image_url)
const imageFile = ref(null)

const onSelectEmoji = (emoji) => {
  emojisText.value = emojisText.value + emoji.i;
  selectEmoji.value = false;
}

const clearEmojis = () => {
  emojisText.value = "";
}

const sendTweet = () => {
  const formData = new FormData();
  if (imageFile.value !== null) {
    formData.append('tweet[image]', imageFile.value[0]) ;
  }
  formData.append('tweet[user_id]', user.value.id);
  formData.append('tweet[content]', emojisText.value);
  $fetch(`${config.public.baseApiUrl}/tweets/${props.tweet.id}`, {
    method: "PATCH",
    credentials: "include",
    body: formData
  }).then(() => {
    emit("closeModal")
  })
};

const displayEmojis = () => {
  selectEmoji.value = !selectEmoji.value;
};
</script>
