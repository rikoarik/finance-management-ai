import '../utils/formatters.dart';
import '../utils/constants.dart';
import '../models/budget.dart';

class BudgetAIPrompts {
  /// Generate AI prompt for budget analysis based on spending history
  static String getBudgetAnalysisPrompt({
    required double monthlyIncome,
    required Map<String, double> categorySpending,
    required Map<String, double> monthlyAverage,
    required int transactionCount,
    required DateTime analysisStartDate,
    required DateTime analysisEndDate,
  }) {
    // Sort categories by spending amount (highest first)
    final sortedCategories = categorySpending.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    // Identify top spending categories
    final topCategories = sortedCategories.take(3).map((e) => '${e.key} (${formatCurrency(monthlyAverage[e.key] ?? 0)}/bulan)').join(', ');
    
    // Calculate total spending
    final totalSpending = categorySpending.values.fold<double>(0, (sum, val) => sum + val);
    final avgMonthlySpending = totalSpending / AppConstants.budgetAnalysisMonths;
    
    // Check if spending exceeds income
    final spendingExceedsIncome = avgMonthlySpending > monthlyIncome;
    
    // Identify wants categories (high priority for reduction)
    final wantsCategories = ['Shopping', 'Entertainment', 'Other'];
    final wantsSpending = categorySpending.entries
        .where((e) => wantsCategories.contains(e.key))
        .fold<double>(0, (sum, e) => sum + (monthlyAverage[e.key] ?? 0));
    
    final categoryBreakdown = sortedCategories
        .map((e) {
          final avg = monthlyAverage[e.key] ?? 0;
          final percentage = avgMonthlySpending > 0 ? (avg / avgMonthlySpending * 100) : 0;
          final isWants = wantsCategories.contains(e.key);
          return '- ${e.key}: ${formatCurrency(e.value)} total (${formatCurrency(avg)}/bulan, ${percentage.toStringAsFixed(1)}%)${isWants ? ' [KATEGORI WANTS - prioritas untuk dikurangi jika berlebihan]' : ''}';
        })
        .join('\n');

    return '''You are a financial advisor AI. Analyze this user's spending data and create a personalized budget with SMART recommendations that prioritize reducing excessive spending in "wants" categories.

INCOME: ${formatCurrency(monthlyIncome)}/bulan

SPENDING HISTORY (${AppConstants.budgetAnalysisMonths} bulan terakhir):
Periode: ${formatDate(analysisStartDate)} - ${formatDate(analysisEndDate)}
Total transaksi: $transactionCount
Rata-rata pengeluaran/bulan: ${formatCurrency(avgMonthlySpending)}
${spendingExceedsIncome ? '⚠️ PERINGATAN: Pengeluaran melebihi pendapatan sebesar ${formatCurrency(avgMonthlySpending - monthlyIncome)}/bulan!' : '✅ Pengeluaran dalam batas aman'}

Pengeluaran per kategori (diurutkan dari terbesar):
$categoryBreakdown

Top 3 kategori pengeluaran terbesar: $topCategories
Total pengeluaran kategori "wants" (Shopping, Entertainment, Other): ${formatCurrency(wantsSpending)}/bulan

TASK: Buat alokasi budget yang SMART dengan analisis mendalam per kategori dan prioritas pengurangan yang jelas.

PRIORITAS PENGURANGAN (SANGAT PENTING - ikuti urutan ini):
1. PRIORITAS TINGGI: Kategori "wants" (Shopping, Entertainment, Other)
   - Jika kategori ini pengeluarannya TINGGI atau berlebihan, WAJIB dikurangi 30-50%
   - Contoh: Jika Shopping rata-rata Rp3,000,000/bulan, berikan budget Rp1,500,000-2,000,000 (kurangi 30-50%)
   - Ini adalah kategori NON-ESSENTIAL, jadi pengurangan tidak akan mempengaruhi kebutuhan dasar

2. PRIORITAS SEDANG: Kategori "needs" yang bisa dioptimalkan (Food, Transport)
   - Jika pengeluarannya sedikit berlebihan, kurangi 10-20%
   - Tetap realistis dan tidak terlalu ketat

3. PRIORITAS RENDAH: Kategori "needs" penting (Bills, Health)
   - Jangan kurangi kecuali sangat perlu dan pengeluarannya jelas berlebihan

4. TIDAK BOLEH dikurangi: Savings, Investment (kecuali pengeluaran sangat tinggi)

REQUIREMENTS:
- Gunakan SEMUA kategori yang ada di history (JANGAN gunakan "Other" sebagai kategori utama kecuali memang ada transaksi dengan kategori tidak jelas)
- Identifikasi kategori mana yang pengeluarannya BERLEBIHAN (khususnya kategori wants seperti Shopping)
- Jika Shopping pengeluarannya tinggi, PASTIKAN amount yang direkomendasikan LEBIH KECIL dari monthlyAverage["Shopping"]
- Berikan alokasi yang REALISTIS tapi dengan pengurangan yang jelas untuk kategori wants yang berlebihan
- Total alokasi harus sama persis dengan monthlyIncome

RESPOND with ONLY valid JSON (no markdown, no code blocks, just pure JSON):
{
  "analysis": "Analisis lengkap dalam bahasa Indonesia (3-4 kalimat) yang menjelaskan pola pengeluaran, kategori mana yang perlu dikurangi (khususnya Shopping jika tinggi), dan strategi pengurangan",
  "recommendations": [
    {
      "category": "Shopping",
      "amount": 1500000,
      "percentage": 0.15,
      "reason": "Pengeluaran rata-rata Rp3,000,000/bulan terlalu tinggi. Dikurangi 50% menjadi Rp1,500,000 untuk mengoptimalkan keuangan dan fokus pada kebutuhan penting"
    },
    {
      "category": "Food",
      "amount": 2000000,
      "percentage": 0.20,
      "reason": "Berdasarkan rata-rata pengeluaran Rp1,800,000 dengan sedikit buffer untuk kenaikan harga"
    }
  ],
  "savings_potential": 500000,
  "tips": [
    "Kurangi pengeluaran Shopping dengan membuat wishlist 30 hari sebelum membeli item non-essential",
    "Prioritaskan pembelian yang benar-benar dibutuhkan",
    "Tip 3 untuk pengelolaan budget yang lebih baik"
  ]
}

IMPORTANT RULES: 
- recommendations array HARUS mencakup SEMUA kategori dari categorySpending (jangan abaikan kategori apapun)
- Jika Shopping ada di history dan pengeluarannya tinggi, PASTIKAN amount di recommendations LEBIH KECIL dari monthlyAverage["Shopping"] (kurangi minimal 30%)
- Jika Entertainment atau kategori wants lain pengeluarannya tinggi, juga WAJIB dikurangi
- Total semua amounts harus = ${formatCurrency(monthlyIncome)} (exact match, tidak boleh lebih atau kurang)
- Setiap recommendation HARUS punya: category (string), amount (number), percentage (decimal 0-1), reason (string)
- reason harus menjelaskan MENGAPA kategori tersebut dikurangi atau dipertahankan, khususnya untuk kategori wants
- Semua teks dalam bahasa Indonesia
- FOKUS pada pengurangan kategori wants (Shopping, Entertainment) yang berlebihan SEBELUM kategori needs
''';
  }

  /// Generate AI prompt for beginner users with no transaction history
  static String getBeginnerBudgetPrompt(double monthlyIncome) {
    return '''You are a financial advisor AI helping a new user set up their first budget.

User's monthly income: ${formatCurrency(monthlyIncome)}
User has NO transaction history yet (new user).

TASK: Provide helpful budget setup tips and suggest a starter budget allocation suitable for Indonesian lifestyle.

RESPOND with ONLY valid JSON (no markdown, no code blocks, just pure JSON):
{
  "welcome_message": "Friendly welcome message in Indonesian (2-3 sentences)",
  "tips": [
    "Tip 1: Pentingnya mencatat setiap pengeluaran",
    "Tip 2: About budget categories",
    "Tip 3: About emergency fund (minimal 3-6 bulan pengeluaran)",
    "Tip 4: Start small and adjust monthly",
    "Tip 5: Track your progress"
  ],
  "starter_budget": [
    {"category": "Food", "amount": 1500000, "percentage": 0.30},
    {"category": "Transport", "amount": 500000, "percentage": 0.10},
    {"category": "Bills", "amount": 750000, "percentage": 0.15},
    {"category": "Health", "amount": 250000, "percentage": 0.05},
    {"category": "Shopping", "amount": 500000, "percentage": 0.10},
    {"category": "Entertainment", "amount": 250000, "percentage": 0.05},
    {"category": "Savings", "amount": 1000000, "percentage": 0.20},
    {"category": "Emergency", "amount": 250000, "percentage": 0.05}
  ]
}

IMPORTANT:
- starter_budget must include 8-10 categories suitable for Indonesian lifestyle
- Total of all amounts must equal ${formatCurrency(monthlyIncome)}
- Follow the 50/30/20 rule guideline (50% needs, 30% wants, 20% savings)
- Each budget item must have: category, amount (number), percentage (decimal 0-1)
- welcome_message and tips must be in Indonesian language
- Tips should be practical and actionable for beginners
''';
  }

  /// Generate AI prompt for comprehensive expense insights
  static String getExpenseInsightsPrompt({
    required Map<String, dynamic> expenseAnalysis,
    Budget? currentBudget,
    double? currentBalance,
    int? daysRemainingInMonth,
  }) {
    final topCategories = expenseAnalysis['topSpendingCategories'] as List<dynamic>? ?? [];
    final dailyRate = expenseAnalysis['dailySpendingRate'] as double? ?? 0.0;
    final projected = expenseAnalysis['projectedMonthlySpending'] as double? ?? 0.0;
    final trends = expenseAnalysis['monthlyTrends'] as List<dynamic>? ?? [];
    final categorySpending = expenseAnalysis['expensesByCategory'] as Map<String, double>? ?? {};
    final monthlyAverage = expenseAnalysis['monthlyAverage'] as Map<String, double>? ?? {};
    
    // Identify wants categories with high spending
    final wantsCategories = ['Shopping', 'Entertainment', 'Other'];
    final highSpendingWants = categorySpending.entries
        .where((e) {
          final avg = monthlyAverage[e.key] ?? 0;
          return wantsCategories.contains(e.key) && avg > 0;
        })
        .toList()
      ..sort((a, b) => (monthlyAverage[b.key] ?? 0).compareTo(monthlyAverage[a.key] ?? 0));
    
    String budgetContext = '';
    if (currentBudget != null) {
      budgetContext = '''
CURRENT BUDGET:
- Monthly Income: ${formatCurrency(currentBudget.monthlyIncome)}
- Total Spent: ${formatCurrency(currentBudget.totalSpent)}
- Remaining: ${formatCurrency(currentBudget.remainingBudget)}
''';
    }
    
    // Add survival analysis if balance and days remaining are provided
    String survivalContext = '';
    if (currentBalance != null && currentBalance > 0 && daysRemainingInMonth != null && daysRemainingInMonth > 0) {
      final targetDailySpending = currentBalance / daysRemainingInMonth;
      final needsReduction = dailyRate > targetDailySpending;
      final reductionNeeded = needsReduction ? (dailyRate - targetDailySpending) : 0.0;
      final projectedSpending = dailyRate * daysRemainingInMonth;
      
      survivalContext = '''

🎯 SURVIVAL ANALYSIS (FOKUS UTAMA):
- Saldo saat ini: ${formatCurrency(currentBalance)}
- Hari tersisa sampai akhir bulan: $daysRemainingInMonth hari
- Rata-rata pengeluaran harian saat ini: ${formatCurrency(dailyRate)}/hari
- Target pengeluaran harian untuk bertahan: ${formatCurrency(targetDailySpending)}/hari
${needsReduction ? '⚠️ PERLU MENGURANGI: ${formatCurrency(reductionNeeded)}/hari (${((reductionNeeded/dailyRate)*100).toStringAsFixed(1)}% pengurangan) untuk bertahan sampai akhir bulan' : '✅ Saldo cukup untuk bertahan sampai akhir bulan dengan pengeluaran saat ini'}
- Proyeksi pengeluaran sisa bulan (dengan rate saat ini): ${formatCurrency(projectedSpending)}
${needsReduction ? '💡 Dengan saldo ${formatCurrency(currentBalance)}, untuk bertahan $daysRemainingInMonth hari, maksimal pengeluaran harian adalah ${formatCurrency(targetDailySpending)}' : ''}
''';
    }
    
    String wantsAnalysis = '';
    if (highSpendingWants.isNotEmpty) {
      wantsAnalysis = '\n\n⚠️ KATEGORI WANTS YANG PERLU DIPERHATIKAN:\n';
      for (var entry in highSpendingWants.take(3)) {
        final avg = monthlyAverage[entry.key] ?? 0;
        final dailyAvg = avg / 30; // Approximate daily average
        wantsAnalysis += '- ${entry.key}: ${formatCurrency(avg)}/bulan (${formatCurrency(dailyAvg)}/hari) [PRIORITAS untuk dikurangi karena kategori wants]\n';
      }
    }

    return '''You are a financial advisor AI. Analyze expense patterns and provide actionable insights with focus on survival strategy and reducing excessive spending in "wants" categories.$survivalContext

EXPENSE ANALYSIS:
$budgetContext
- Top Categories: ${topCategories.join(', ')}
- Daily Spending Rate: ${formatCurrency(dailyRate)}/hari
- Projected Monthly: ${formatCurrency(projected)}
- Monthly Trends (last 3 months): ${trends.map((t) => formatCurrency(t as double)).join(', ')}$wantsAnalysis

TASK: Provide comprehensive expense insights dengan FOKUS pada survival strategy:
${currentBalance != null && daysRemainingInMonth != null ? '1. PRIORITAS: Berikan strategi spesifik PER KATEGORI untuk mengurangi pengeluaran agar saldo bisa bertahan sampai akhir bulan' : '1. Trend analysis per kategori (naik/turun compared to previous months)'}
2. Warning alerts khusus untuk kategori wants (Shopping, Entertainment) yang pengeluarannya tinggi
3. Specific recommendations PER KATEGORI untuk mengurangi pengeluaran, terutama kategori wants
4. Anomaly detection (unusual patterns)
${currentBalance != null && daysRemainingInMonth != null ? '5. Survival recommendations: Saran spesifik untuk mengurangi pengeluaran harian dari ${formatCurrency(dailyRate)} menjadi target yang diperlukan' : ''}

PRIORITAS REKOMENDASI:
${currentBalance != null && daysRemainingInMonth != null ? '- Dengan saldo saat ini ${formatCurrency(currentBalance)} dan $daysRemainingInMonth hari tersisa, fokuskan rekomendasi pada pengurangan kategori wants (Shopping, Entertainment) yang bisa langsung mengurangi pengeluaran harian' : ''}
- Jika Shopping atau Entertainment pengeluarannya tinggi, WAJIB berikan rekomendasi spesifik untuk mengurangi kategori tersebut
- Fokus pada kategori wants sebelum kategori needs
- Berikan saran actionable dan spesifik dengan jumlah pengurangan yang jelas

RESPOND with ONLY valid JSON (no markdown, no code blocks):
{
  "trend": "Analisis trend dalam bahasa Indonesia ${currentBalance != null && daysRemainingInMonth != null ? 'dengan fokus pada survival strategy - apakah saldo bisa bertahan sampai akhir bulan dan kategori apa yang perlu dikurangi' : '(naik/turun, stable, etc.) dengan fokus pada kategori wants yang perlu dikurangi'}",
  "warnings": [
    ${currentBalance != null && daysRemainingInMonth != null ? '"Dengan saldo saat ini ${formatCurrency(currentBalance)} dan $daysRemainingInMonth hari tersisa, perlu mengurangi pengeluaran harian untuk bertahan sampai akhir bulan",' : ''}
    "Warning jika Shopping/Entertainment pengeluarannya tinggi dan perlu dikurangi",
    "Warning jika spending velocity too high",
    "Warning jika projected exceeds budget"
  ],
  "recommendations": [
    ${currentBalance != null && daysRemainingInMonth != null && dailyRate > 0 ? '"Kurangi pengeluaran Shopping dengan membuat wishlist 30 hari sebelum membeli item non-essential (bisa hemat ${formatCurrency((dailyRate - (currentBalance / daysRemainingInMonth)) * 0.3)}/hari jika Shopping dikurangi 30%)",' : ''}
    "Rekomendasi spesifik untuk mengurangi Shopping jika pengeluarannya tinggi (misal: Buat wishlist 30 hari, hindari impulse buying)",
    "Rekomendasi spesifik untuk kategori wants lain yang perlu dikurangi",
    "Rekomendasi umum untuk optimisasi pengeluaran"
  ],
  "anomalies": [
    "Anomaly jika terdeteksi pola tidak biasa (misal: Shopping melonjak drastis)"
  ],
  "spending_velocity_status": "normal|high|very_high",
  "projected_status": "safe|warning|danger"
}

IMPORTANT:
- All text must be in Indonesian language
- Be specific and actionable, terutama untuk kategori wants (Shopping, Entertainment)
${currentBalance != null && daysRemainingInMonth != null ? '- Jika saldo tidak cukup untuk bertahan sampai akhir bulan, WAJIB berikan rekomendasi spesifik dengan jumlah pengurangan yang jelas per kategori' : ''}
- Jika Shopping atau kategori wants lain pengeluarannya tinggi, PASTIKAN ada warning dan rekomendasi spesifik untuk kategori tersebut
- warnings dan recommendations harus relevan dengan data yang diberikan
- If no warnings, warnings array can be empty
''';
  }
  
  /// Generate AI prompt for balance survival analysis
  /// Focuses on how to survive until end of month with current balance
  static String getBalanceSurvivalPrompt({
    required double currentBalance,
    required int daysRemaining,
    required double dailySpendingRate,
    required Map<String, double> categorySpending,
    required Map<String, double> monthlyAverage,
  }) {
    // Calculate target daily spending
    final targetDailySpending = currentBalance / daysRemaining;
    final needsReduction = dailySpendingRate > targetDailySpending;
    final reductionAmount = needsReduction ? (dailySpendingRate - targetDailySpending) : 0.0;
    final reductionPercentage = dailySpendingRate > 0 ? (reductionAmount / dailySpendingRate * 100) : 0.0;
    
    // Calculate daily average per category
    final categoryDailyAverage = <String, double>{};
    monthlyAverage.forEach((category, avg) {
      categoryDailyAverage[category] = avg / 30; // Approximate daily average
    });
    
    // Identify wants categories
    final wantsCategories = ['Shopping', 'Entertainment', 'Other'];
    
    // Sort categories by daily spending (highest first)
    final sortedCategories = categoryDailyAverage.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final categoryBreakdown = sortedCategories
        .map((e) {
          final isWants = wantsCategories.contains(e.key);
          final currentDaily = e.value;
          final projectedRemaining = currentDaily * daysRemaining;
          return '- ${e.key}: ${formatCurrency(monthlyAverage[e.key] ?? 0)}/bulan (${formatCurrency(currentDaily)}/hari) → Proyeksi sisa bulan: ${formatCurrency(projectedRemaining)}${isWants ? ' [KATEGORI WANTS - prioritas untuk dikurangi]' : ''}';
        })
        .join('\n');

    return '''You are a financial advisor AI. Your task is to help user survive until the end of month with their current balance by providing specific category-based reduction recommendations.

🎯 SITUASI SAAT INI (SANGAT PENTING):
- Saldo tersisa: ${formatCurrency(currentBalance)}
- Hari tersisa sampai akhir bulan: $daysRemaining hari
- Rata-rata pengeluaran harian saat ini: ${formatCurrency(dailySpendingRate)}/hari
- Target pengeluaran harian untuk bertahan: ${formatCurrency(targetDailySpending)}/hari
${needsReduction ? '⚠️ PERLU MENGURANGI: ${formatCurrency(reductionAmount)}/hari (${reductionPercentage.toStringAsFixed(1)}% pengurangan) agar saldo bisa bertahan sampai akhir bulan' : '✅ Saldo cukup untuk bertahan dengan pengeluaran saat ini'}
- Total pengeluaran proyeksi (dengan rate saat ini): ${formatCurrency(dailySpendingRate * daysRemaining)}
- Saldo akan habis dalam: ${dailySpendingRate > 0 ? (currentBalance / dailySpendingRate).floor() : 0} hari (dengan pengeluaran saat ini)

PENGELUARAN PER KATEGORI (berdasarkan history):
$categoryBreakdown

TASK: Berikan analisis survival dan rekomendasi spesifik PER KATEGORI untuk mengoptimalkan pengeluaran agar saldo bisa bertahan sampai akhir bulan.

REQUIREMENTS:
1. KATEGORI ANALYSIS:
   - Gunakan SEMUA kategori yang ada di history (JANGAN gunakan "Other" kecuali kategori memang tidak jelas)
   - Identifikasi kategori mana yang bisa dikurangi untuk mencapai target pengeluaran harian
   - Berikan analisis khusus untuk kategori dengan pengeluaran tinggi

2. PRIORITAS PENGURANGAN (SANGAT PENTING - ikuti urutan ini):
   - PRIORITAS TINGGI: Kategori "wants" (Shopping, Entertainment, Other) → KURANGI DULU karena non-essential
     * Jika Shopping pengeluarannya tinggi, kurangi 40-60% dari daily average
     * Jika Entertainment tinggi, kurangi 30-50%
   - PRIORITAS SEDANG: Kategori "needs" yang bisa dioptimalkan (Food, Transport) → Kurangi 10-20% jika perlu
   - PRIORITAS RENDAH: Kategori "needs" penting (Bills, Health) → Jangan kurangi kecuali sangat perlu
   - TIDAK BOLEH kurangi: Savings, Investment

3. SURVIVAL STRATEGY:
   - Hitung total pengurangan yang diperlukan per kategori untuk mencapai target harian ${formatCurrency(targetDailySpending)}
   - Berikan alokasi harian maksimal per kategori untuk sisa bulan
   - Pastikan total pengurangan dari semua kategori >= ${formatCurrency(reductionAmount)}/hari

4. ANALYSIS & REASONING:
   - Jelaskan MENGAPA kategori tertentu perlu dikurangi lebih banyak (misal: "Shopping adalah kategori wants dengan pengeluaran tertinggi, kurangi 50% untuk prioritas kebutuhan dasar")
   - Berikan saran spesifik dan actionable per kategori

RESPOND with ONLY valid JSON (no markdown, no code blocks, just pure JSON):
{
  "survival_analysis": "Analisis survival lengkap dalam bahasa Indonesia (4-5 kalimat) yang menjelaskan apakah saldo cukup, strategi yang diperlukan, dan kategori mana yang perlu dikurangi",
  "can_survive": ${!needsReduction},
  "required_daily_reduction": ${reductionAmount},
  "target_daily_spending": ${targetDailySpending},
  "estimated_days_with_current_rate": ${dailySpendingRate > 0 ? (currentBalance / dailySpendingRate).floor() : 0},
  "category_recommendations": [
    {
      "category": "Shopping",
      "current_daily_avg": ${categoryDailyAverage['Shopping'] ?? 0},
      "current_month_projection": ${(categoryDailyAverage['Shopping'] ?? 0) * daysRemaining},
      "recommended_daily_limit": ${(categoryDailyAverage['Shopping'] ?? 0) * 0.5},
      "recommended_total_limit": ${(categoryDailyAverage['Shopping'] ?? 0) * 0.5 * daysRemaining},
      "reduction_amount": ${(categoryDailyAverage['Shopping'] ?? 0) * 0.5},
      "reduction_percentage": 50.0,
      "priority": "high",
      "reason": "Kategori wants dengan pengeluaran terbesar. Dikurangi 50% untuk fokus pada kebutuhan penting agar saldo bisa bertahan sampai akhir bulan",
      "actionable_tips": [
        "Buat wishlist 30 hari sebelum membeli item non-essential",
        "Hindari window shopping dan belanja online tanpa rencana",
        "Tanyakan 'Apakah ini benar-benar perlu?' sebelum setiap pembelian"
      ]
    }
  ],
  "total_reduction_possible": ${reductionAmount * 1.2},
  "survival_strategy": "Strategi lengkap dalam bahasa Indonesia untuk bertahan sampai akhir bulan dengan saldo saat ini, termasuk tips harian dan kategori mana yang harus diprioritaskan"
}

IMPORTANT RULES:
- category_recommendations HARUS mencakup SEMUA kategori dari categorySpending yang ada di history
- Untuk kategori wants (Shopping, Entertainment, Other) yang pengeluarannya tinggi, PASTIKAN reduction_percentage >= 30%
- Total reduction_amount dari semua kategori harus >= required_daily_reduction
- Priority: "high" (wants categories), "medium" (needs yang bisa dioptimalkan), "low" (needs penting)
- Setiap category_recommendation HARUS punya: category, current_daily_avg, current_month_projection, recommended_daily_limit, recommended_total_limit, reduction_amount, reduction_percentage, priority, reason, actionable_tips
- Semua teks dalam bahasa Indonesia
- FOKUS pada survival sampai akhir bulan dengan saldo saat ini
''';
  }

  /// Generate AI prompt for income insights
  static String getIncomeInsightsPrompt({
    required Map<String, dynamic> incomeAnalysis,
    required Map<String, dynamic> expenseAnalysis,
  }) {
    final totalIncome = incomeAnalysis['totalIncome'] as double? ?? 0.0;
    final avgIncome = incomeAnalysis['averageMonthlyIncome'] as double? ?? 0.0;
    final currentIncome = incomeAnalysis['currentMonthIncome'] as double? ?? 0.0;
    final isStable = incomeAnalysis['isStable'] as bool? ?? true;
    final topSources = incomeAnalysis['topIncomeSources'] as List<dynamic>? ?? [];
    final totalExpense = expenseAnalysis['totalExpense'] as double? ?? 0.0;
    final savingsRate = totalIncome > 0 ? ((totalIncome - totalExpense) / totalIncome) * 100 : 0.0;

    return '''You are a financial advisor AI. Analyze income patterns and provide insights.

INCOME ANALYSIS:
- Total Income (3 months): ${formatCurrency(totalIncome)}
- Average Monthly: ${formatCurrency(avgIncome)}
- Current Month: ${formatCurrency(currentIncome)}
- Income Stability: ${isStable ? 'Stable' : 'Irregular'}
- Top Income Sources: ${topSources.map((s) => '${s['category']}: ${formatCurrency(s['amount'] as double)}').join(', ')}

EXPENSE ANALYSIS:
- Total Expenses (3 months): ${formatCurrency(totalExpense)}
- Savings Rate: ${savingsRate.toStringAsFixed(1)}%

TASK: Provide comprehensive income insights with:
1. Income sufficiency analysis (vs expenses)
2. Income stability assessment
3. Savings potential calculation
4. Recommendations to increase income or optimize expenses

RESPOND with ONLY valid JSON (no markdown, no code blocks):
{
  "analysis": "Brief income analysis in Indonesian (sufficiency, stability, savings potential)",
  "sufficiency_status": "sufficient|tight|insufficient",
  "stability_status": "stable|moderate|irregular",
  "savings_potential": 500000,
  "recommendations": [
    "Recommendation 1 for income optimization",
    "Recommendation 2 for expense reduction",
    "Recommendation 3 for savings goals"
  ],
  "income_goals": [
    "Goal 1 to increase income if applicable",
    "Goal 2 for financial improvement"
  ]
}

IMPORTANT:
- All text must be in Indonesian language
- Be specific and actionable
- savings_potential is the calculated potential savings amount
- recommendations should focus on actionable steps
''';
  }
}

