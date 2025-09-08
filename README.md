**Lazy Loading Demo — Project Summary**

A small Flutter demo that implements lazy-loading (infinite scroll) while fetching data from a remote API. This section summarizes what I built, what I learned, and how to run the project.

****Project purpose****

Show how to fetch paginated/dummy data from an API and load more items as the user scrolls, while handling common real-world issues like inconsistent JSON types, network errors, and UI edge-cases.

Key features

Infinite scroll using ListView.builder + ScrollController.

Client-side pagination (simulated with skip/take) and support for server-side pagination.

Defensive JSON parsing to handle inconsistent API responses.

Loading indicator, hasMore flag.

Simple, reusable UserModel / Product model parsing patterns.

What I learned / accomplished

Implemented infinite-scroll logic:

Used isLoading to prevent duplicate requests

Used hasMore to stop further calls when API returns fewer items than requested

Reserved an extra item in itemCount for loader UI and guarded access with if (index < items.length)

Improved lifecycle safety with initState, dispose().

Added debugging practices: print response.body and field runtime types during development to inspect API responses.

Implementation notes (files changed)

models/user_model.dart — corrected field mapping and added defensive parsing.

models/product_model.dart — similar defensive parsing for product fields.

api_service.dart — robust fetch function with response checks and safe mapping.

views/users.dart / views/products.dart — infinite-scroll UI, loader and hasMore logic.

How to run

Clone the repo.

Run flutter pub get.

Start the app with flutter run (or use your IDE).

Open the Users / Products screen and scroll to trigger lazy loading.

Developer tips

Prefer server-side pagination (page / per_page) when available — it scales better than client-side slicing.

Use defensive parsing for third-party or unstable APIs to avoid runtime crashes.

Use extentAfter for prefetching to give a smoother loading experience.

Always dispose() controllers and check mounted before setState() after async calls.
