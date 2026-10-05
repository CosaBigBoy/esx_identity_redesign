<script setup>
import { onMounted } from 'vue'
import Identity from './components/Identity.vue'

onMounted(() => {
  fetch(`https://${GetParentResourceName()}/ready`, {
    method: 'POST',
    body: JSON.stringify({})
  })

  window.addEventListener('message', (event) => {
    if (event.data.type === 'enableui') {
      document.body.classList[event.data.enable ? 'remove' : 'add']('none')

      if (event.data.theme) {
        const root = document.documentElement
        const theme = event.data.theme
        Object.entries(theme).forEach(([key, value]) => {
          root.style.setProperty(`--${key.replace(/[A-Z]/g, m => '-' + m.toLowerCase())}`, value)
        })
      }
    }
  })
})
</script>

<template>
  <Identity />
</template>
