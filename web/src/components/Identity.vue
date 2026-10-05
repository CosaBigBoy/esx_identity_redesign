<script setup>
import { Form, Field, ErrorMessage } from 'vee-validate'
import * as yup from 'yup'
import moment from 'moment'

const onSubmit = (values) => {
  fetch(`https://${GetParentResourceName()}/register`, {
    method: 'POST',
    body: JSON.stringify({
      firstname: values.firstname.trim(),
      lastname: values.lastname.trim(),
      dateofbirth: moment(values.dob).format('DD/MM/YYYY'),
      sex: values.gender,
      height: values.height,
    }),
  })
}

const schema = yup.object({
  firstname: yup.string().required('First name is required').min(3, 'At least 3 characters').max(20, 'Maximum 20 characters'),
  lastname: yup.string().required('Last name is required').min(3, 'At least 3 characters').max(20, 'Maximum 20 characters'),
  dob: yup.date().required('Date of birth is required').min(new Date('1900-01-01'), 'Date is too early').max(moment().subtract(1, 'years').toDate(), 'Invalid age'),
  gender: yup.string().required('Select a gender'),
  height: yup.number().required('Height is required').min(120, 'Minimum 120 cm').max(220, 'Maximum 220 cm').typeError('Enter a valid height'),
})
</script>

<template>
  <main class="identity-shell">
    <section class="identity-card">
      <div class="accent-line"></div>

      <header class="brand">
        <div class="brand-mark">
          <img src="/logo.png" alt="Identity" />
        </div>
        <div class="brand-copy">
          <span class="eyebrow">CITY REGISTRATION</span>
          <h1>Create your <strong>identity</strong></h1>
          <p>Set up your character profile to enter the city.</p>
        </div>
        <div class="status">
          <span class="status-dot"></span>
          SECURE
        </div>
      </header>

      <div class="divider"></div>

      <Form class="form" id="register" action="#" novalidate @submit="onSubmit" :validation-schema="schema">
        <div class="section-heading">
          <span class="section-number">01</span>
          <div>
            <h2>Personal information</h2>
            <p>Tell us how your character will be known.</p>
          </div>
        </div>

        <div class="grid two">
          <div class="field-wrap">
            <label for="firstname">First name</label>
            <div class="input-box">
              <span class="input-icon">A</span>
              <Field id="firstname" type="text" name="firstname" placeholder="e.g. Michael" autocomplete="off" validateOnInput />
            </div>
            <ErrorMessage name="firstname" class="error" />
          </div>

          <div class="field-wrap">
            <label for="lastname">Last name</label>
            <div class="input-box">
              <span class="input-icon">Z</span>
              <Field id="lastname" type="text" name="lastname" placeholder="e.g. Carter" autocomplete="off" validateOnInput />
            </div>
            <ErrorMessage name="lastname" class="error" />
          </div>
        </div>

        <div class="grid two">
          <div class="field-wrap">
            <label for="dob">Date of birth</label>
            <div class="input-box">
              <span class="input-icon">▣</span>
              <Field id="dob" type="date" name="dob" validateOnInput />
            </div>
            <ErrorMessage name="dob" class="error" />
          </div>

          <div class="field-wrap">
            <label for="height">Height</label>
            <div class="input-box">
              <span class="input-icon">↕</span>
              <Field id="height" type="number" name="height" min="120" max="220" placeholder="175" validateOnInput />
              <span class="unit">CM</span>
            </div>
            <ErrorMessage name="height" class="error" />
          </div>
        </div>

        <div class="field-wrap">
          <label>Gender</label>
          <div class="gender-grid">
            <div class="gender-option">
              <Field type="radio" id="male" value="m" name="gender" validateOnInput />
              <label for="male">
                <span class="gender-symbol">♂</span>
                <span><b>Male</b><small>Character identity</small></span>
                <span class="check">✓</span>
              </label>
            </div>
            <div class="gender-option">
              <Field type="radio" id="female" value="f" name="gender" validateOnInput />
              <label for="female">
                <span class="gender-symbol">♀</span>
                <span><b>Female</b><small>Character identity</small></span>
                <span class="check">✓</span>
              </label>
            </div>
          </div>
          <ErrorMessage name="gender" class="error" />
        </div>

        <div class="footer-row">
          <div class="tip">
            <span>i</span>
            Your details are saved securely to your character profile.
          </div>
          <button class="submit" id="submit" type="submit">
            <span>Create character</span>
            <b>→</b>
          </button>
        </div>
      </Form>
    </section>
  </main>
</template>
