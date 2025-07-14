import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm';

const supabaseUrl ="https://qbnaecujbshbkritaddj.supabase.co";
const supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFibmFlY3VqYnNoYmtyaXRhZGRqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkxMjQwNTEsImV4cCI6MjA2NDcwMDA1MX0.Bbf9OTqEd3PkWA-sIUsVH23xWYjpF8JAN3dKAny0TVs";  

const supabase = createClient(supabaseUrl, supabaseKey);

document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('loginForm');
  const errorMsg = document.getElementById('errorMsg');

  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password
      });

      if (error) {
        throw error;
      }

      // Save session flag if you want
      localStorage.setItem('isLoggedIn', 'true');

      // Redirect
      window.location.href = 'admin-dashboard.html';
    } catch (error) {
      errorMsg.textContent = 'Invalid credentials';
      errorMsg.classList.remove('hidden');
    }
  });
});
