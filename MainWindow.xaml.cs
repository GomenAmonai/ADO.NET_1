using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Windows;

namespace SongsApp
{
    public partial class MainWindow : Window
    {
        private readonly string _connStr = "Data Source=SERVER_NAME;Initial Catalog=MusicDB;User ID=USER;Password=PWD;";

        public MainWindow()
        {
            InitializeComponent();
            LoadAndDisplaySongs();
        }

        private void LoadAndDisplaySongs()
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(_connStr))
            using (var cmd  = new SqlCommand("SELECT song_id, title, artist, file_size_kb, duration_sec FROM dbo.songs", conn))
            using (var da   = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }

            SongsGrid.ItemsSource = dt.DefaultView;

            // Считаем суммы
            int totalSize = dt.AsEnumerable().Sum(r => r.Field<int>("file_size_kb"));
            int totalDur  = dt.AsEnumerable().Sum(r => r.Field<int>("duration_sec"));

            LblTotalSize.Content      = $"Суммарный вес: {totalSize:N0} КБ";
            LblTotalDuration.Content  = $"Суммарная длительность: {totalDur:N0} сек";
        }
    }
}
