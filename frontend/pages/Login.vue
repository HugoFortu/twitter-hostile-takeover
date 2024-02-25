<template>
  <div>
    <v-form v-if="newAccount">
      <v-container>
        <v-card class="login">
          <v-card-title>
            Inscription
          </v-card-title>
          <v-col
            cols="12"
            md="12"
          >
            <v-text-field
              v-model="subEmail"
              label="Email"
              hide-details
              required
            ></v-text-field>
          </v-col>

          <v-col
            cols="12"
            md="12"
          >
            <v-text-field
              v-model="subPassword"
              :counter="10"
              label="Mot de passe"
              hide-details
              required
            ></v-text-field>
          </v-col>
          <v-col
              cols="12"
              md="12"
          >
            <v-text-field
                v-model="subPasswordConfirmation"
                :counter="10"
                label="Confirmer le mot de passe."
                hide-details
                required
            ></v-text-field>
          </v-col>
          <v-col
            cols="12"
            md="12"
            class="text-right"
          >
              <v-btn
                @click="newAccount = false"
                class="mr-5"
                >
                Annuler
              </v-btn>
            <v-btn
              :disabled="subPassword === '' || subEmail === '' || subPasswordConfirmation === ''"
              @click="registration">
              Valider
            </v-btn>
          </v-col>
        </v-card>
      </v-container>
    </v-form>
    <v-form v-else>
      <v-container >
        <v-card class="login">
          <v-card-title>
            Connexion
          </v-card-title>
          <v-col
              cols="12"
              md="12"
          >
            <v-text-field
                v-model="email"
                label="Email"
                hide-details
                required
            ></v-text-field>
          </v-col>
          <v-col
              cols="12"
              md="12"
          >
            <v-text-field
                v-model="password"
                :counter="10"
                label="Mot de passe"
                hide-details
                required
            ></v-text-field>
          </v-col>
           <v-col
                cols="12"
                md="12"
                class="text-right"
            >
            <span class="mr-2">Pas encore de compte?</span>
            <v-btn
              density="compact"
              icon="mdi-plus"
              class="mr-5"
              @click="newAccount = true"
            ></v-btn>

            <v-btn @click="login"
              :disabled="password === '' || email === ''"
            >
              Valider
            </v-btn>
          </v-col>
        </v-card>
      </v-container>
    </v-form>
  </div>
</template>


<script setup>
import { ref } from "vue";

const config = useRuntimeConfig();
const newAccount = ref(false);
const email = ref("");
const password = ref("");
const subEmail = ref("");
const subPassword = ref("");
const subPasswordConfirmation = ref("");
const registration = () => {
  $fetch.raw(`${config.public.baseApiUrl}/users`, {
    method: "POST",
    credentials: "include",
    body: {
      user: {
        email: subEmail.value,
        password: subPassword.value,
        password_confirmation: subPasswordConfirmation.value
      }
    },
  }).then((response) => {
    if (response.ok) {
      sessionStorage.setItem("isLogged", response.ok);
      sessionStorage.setItem("token", response.headers.get("authorization").split(' ')[1]);
      return navigateTo('/');
    }
  })
}

const login = () => {
  $fetch.raw(`${config.public.baseApiUrl}/users/sign_in`, {
    method: "POST",
    credentials: "include",
    body: {
      user: {
        email: email.value,
        password: password.value
      }
    },
  })
      .then((response) => {
        sessionStorage.setItem("isLogged", response.ok);
        if (response.ok) {
          sessionStorage.setItem("token", response.headers.get("authorization").split(' ')[1]);
          return navigateTo('/');
        }
      })
}


</script>
