# Aarohan Pocket 2.2 — GitHub Pages deployment

## Stage A: Publish the application (public code only)

1. On GitHub, create a new repository named `aarohan-pocket` (public repo works on GitHub Free). Do not add a README/license when creating it, to simplify upload.
2. Download and extract the `Aarohan_Pocket_GitHub_Pages_Ready.zip` file. The ZIP contains **only** the static Pocket app: `index.html`, `config.js`, `manifest.webmanifest`, `sw.js`, `assets/`, and `.nojekyll`, plus these instructions. It does **not** contain your personal practice bundle, Windows database, transcripts or secret keys.
3. In the new repo, choose **Add file → Upload files**. Upload the **contents of the extracted folder** to the repository root—not the ZIP itself. Ensure `index.html` ends up at root and `assets/` remains a folder. Commit.
4. Go to **Settings → Pages → Build and deployment**, choose **Deploy from a branch**, then choose `main` and `/(root)`; click **Save**.
5. When the Pages deployment succeeds, open `https://YOUR-USERNAME.github.io/aarohan-pocket/` (substitute your GitHub username). It should display Aarohan Pocket, initially in **offline mode** because `config.js` is blank.

> **Privacy:** GitHub Pages serves static files publicly. NEVER upload a private practice JSON, `.env`, API keys, databases or full transcripts to GitHub. Your private JSON stays on your phone after you import it; GitHub hosts only the app code. If someone else visits your site, they will not see your locally imported records.

## Stage B: Install the PWA and import your learning

1. Transfer the Aarohan **Private Practice Bundle** `.json` file from your Windows PC to your phone privately, e.g., AirDrop, iCloud Drive, USB, your own Google Drive. Do not commit it to GitHub.
2. On an iPhone, open the Pages URL in **Safari** → Share → **Add to Home Screen** → **Open as Web App** (when shown) → Add. On Android, open in Chrome → browser menu → **Install app** or **Add to Home screen**.
3. **Open the installed home-screen app** and choose **Progress** → **Import Practice Bundle** → select the transferred JSON file. Do the import after installation so the data is stored in the PWA's own browser storage.
4. Check **Today**, **Lexicon**, and **Practice**. Personal cards should appear. Repeat attempts are stored on-device in IndexedDB.
5. To return practice results to Windows without cloud sync: **Progress** → **Export local practice results** → transfer the generated `.json` to Windows → Aarohan 2.2 **Pocket Sync** → **Import phone practice results**.

## Stage C (optional): True one-click two-way sync

GitHub Pages by itself is static hosting. It does NOT sync private data between Windows and mobile. To enable live sync later:

1. Create a Supabase project; run `schema.sql` in the SQL Editor and configure email OTP.
2. Use your Supabase **Project URL** and **public publishable/anon key** in `config.js` (safe to publish). Never add a secret/service-role key.
3. Configure the same values in the desktop `.env`; restart Windows Aarohan.
4. Sign in using the same email on both devices and press **Sync to Phone** on Windows and **Sync phone now** on mobile.

See the Windows ZIP `POCKET_SETUP.md` for the full Supabase configuration and security details.

## Common problems

- **404:** Ensure `index.html` is at the repo root and Pages source is `main` → `/(root)`; wait for the GitHub Pages deployment status to show success.
- **App loads but no cards:** This is expected before you import your private JSON or configure cloud sync. Open **Progress → Import Practice Bundle**.
- **No install option:** Use HTTPS GitHub Pages, Safari on iPhone or Chrome on Android. Try **Add to Home Screen**.
- **After updating, old interface persists:** Reload the PWA or close and reopen it; service workers may use a prior cached version until updated.
- **Phone practice doesn't appear on Windows:** Manual transfer requires **Export local practice results** on the phone and **Import phone practice results** in Windows. GitHub Pages alone doesn't provide automatic back-sync.
- **Lost offline cards after reinstall:** Clearing PWA storage or removing and reinstalling an app can erase local data; keep a private copy of the Windows practice bundle and regularly export practice results.
