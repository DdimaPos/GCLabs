class GOL {
  int w = 8;
  int columns, rows;
  int[][] board;

  GOL() {
    columns = width / w;
    rows = height / w;
    board = new int[columns][rows];
    init();
  }

  void init() {
    for (int i = 1; i < columns - 1; i++) {
      for (int j = 1; j < rows - 1; j++) {
        board[i][j] = int(random(2));
      }
    }
  }

  void setCellAlive(int mouseX, int mouseY) {
    // Determine the cell index based on the mouse position
    int cellX = mouseX / w;
    int cellY = mouseY / w;

    // Ensure the indices are within bounds
    if (cellX >= 0 && cellX < columns && cellY >= 0 && cellY < rows) {
      board[cellX][cellY] = 1; // Set the cell to "alive"
    }
  }

  void generate() {
    int[][] next = new int[columns][rows];

    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        int neighbors = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            neighbors += board[(x + i + columns) % columns][(y + j + rows) % rows];
          }
        }

        neighbors -= board[x][y];

        if ((board[x][y] == 1) && (neighbors < 2)) next[x][y] = 0; 
        else if ((board[x][y] == 1) && (neighbors > 3)) next[x][y] = 0;
        else if ((board[x][y] == 0) && (neighbors == 3)) next[x][y] = 1;
        else next[x][y] = board[x][y];
      }
    }
    board = next;
  }

  void display() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        if (board[i][j] == 1) fill(0);
        else fill(255);
        stroke(0);
        rect(i * w, j * w, w, w);
      }
    }
  }
}

