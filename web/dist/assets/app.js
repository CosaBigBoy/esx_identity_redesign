(() => {
  const root = document.documentElement;
  const body = document.body;
  const form = document.getElementById('register');

  const setTheme = (theme) => {
    if (!theme) return;
    Object.entries(theme).forEach(([key, value]) => {
      const cssName = key.replace(/[A-Z]/g, m => '-' + m.toLowerCase());
      root.style.setProperty(`--${cssName}`, value);
    });
  };

  const post = (endpoint, data = {}) =>
    fetch(`https://${GetParentResourceName()}/${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=UTF-8' },
      body: JSON.stringify(data)
    });

  const clearErrors = () =>
    document.querySelectorAll('.error').forEach(el => el.textContent = '');

  const error = (id, message) => {
    const el = document.getElementById(`${id}-error`);
    if (el) el.textContent = message;
  };

  const formatDate = (value) => {
    const [year, month, day] = value.split('-');
    return `${day}/${month}/${year}`;
  };

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    clearErrors();

    const firstname = document.getElementById('firstname').value.trim();
    const lastname = document.getElementById('lastname').value.trim();
    const dob = document.getElementById('dob').value;
    const height = Number(document.getElementById('height').value);
    const gender = document.querySelector('input[name="gender"]:checked')?.value;

    let valid = true;
    if (firstname.length < 3) { error('firstname', 'At least 3 characters'); valid = false; }
    if (firstname.length > 20) { error('firstname', 'Maximum 20 characters'); valid = false; }
    if (lastname.length < 3) { error('lastname', 'At least 3 characters'); valid = false; }
    if (lastname.length > 20) { error('lastname', 'Maximum 20 characters'); valid = false; }
    if (!dob) { error('dob', 'Date of birth is required'); valid = false; }
    if (!height || height < 120 || height > 220) { error('height', 'Height must be 120–220 cm'); valid = false; }
    if (!gender) { error('gender', 'Select a gender'); valid = false; }
    if (!valid) return;

    const button = document.getElementById('submit');
    button.disabled = true;
    button.querySelector('span').textContent = 'Creating...';

    try {
      await post('register', {
        firstname,
        lastname,
        dateofbirth: formatDate(dob),
        sex: gender,
        height
      });
    } finally {
      button.disabled = false;
      button.querySelector('span').textContent = 'Create character';
    }
  });

  window.addEventListener('message', (event) => {
    const data = event.data || {};
    if (data.type === 'enableui') {
      body.classList.toggle('none', !data.enable);
      if (data.theme) setTheme(data.theme);
    }
  });

  post('ready');
})();
