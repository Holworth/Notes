package x10;

import x10.io.*;

import x10.io.Console;

import x10.array.*;

import x10.util.*;





public class waterman_parallel_diagonal {

	static val letterValue = new HashMap[Char,Long]();

	//=================================================================================================

	// build the Blosum dict;

	public static def buildBlosum(inputBlosum: String):Array_2[Long]{
		val blosum = new Array_2[Long](50, 50,0);
		try {
			var counter:Long = 0;
			val input = new File(inputBlosum);
			for (line in input.lines()) {
				if (line.indexOf("#")== (-1 as Int)){
					if(counter == 0){   // first line
						var letterIndex:Long = 0;
						val preline:String = line.trim();
						val tokens:Rail[String] = preline.split(" ");
						for(i in 0..(tokens.size-1) as Int){
							if (tokens(i).trim().length()!=0 as Int)
								letterValue.put(tokens(i).trim().charAt(0 as Int), letterIndex);
							letterIndex++;
						}
					}
					else {
						var letterIndex:Long = 0;
						val preline:String = line.trim();
						val tokens:Rail[String] = preline.split(" ");
						for(i in 1..(tokens.size-1) as Int){
							if (tokens(i).trim().length()!=0 as Int){
								blosum(counter-1, letterIndex) = Long.parse(tokens(i).trim());
								letterIndex++;
							}		
						}
					}
					
					counter++;
				}

				
			}
			return blosum;
		}

		catch (e: IOException) { 

			Console.OUT.println(e);  

		}

		return null;
	};

	//=================================================================================================

	

	

	//=================================================================================================

	//penalty function;

	public static def penalty(a:Long,b:Long,l:Long): Long{

		return a+b*(l-1);

	}

	//=================================================================================================

	

	

	//=================================================================================================

	// parse the input files;

   public static def parseInput(inputPath: String): Rail[Char]{

   try {

   val input = new File(inputPath);

   var fullLength:Long = 0;

   val charList = new ArrayList[Char]();

   var count:Long = 0;

   	for (line in input.lines()) {

   		if(count!=0){

   			fullLength+=line.length();

   		val output:Rail[Char] = line.chars();

   		for (ch in output){

   			charList.add(ch);

   		}

   		}

   		count++;

   	}

   	val ret:Rail[Char] = charList.toRail();

   	return ret;



   }

   catch (e: IOException) { 

	   Console.OUT.println(e);  

   	}

   return null;

   };

   //=================================================================================================



   

   

   

   

   //=================================================================================================

   // calculate the score matrix;


   public static def thread_task(r:Long, c:Long, scoreMatrix: Array_2[Long], input1:Rail[Char],input2:Rail[Char],blosum:Array_2[Long], current_position:Array_1[Long],A:Long,B:Long): Long{
	   //r, c -> start position

	   // start new task
	   // sequence:
	   // -->-->-->
	   //         |
	   //         v
	   //         |
	   //         v

	if((c+1)<=input2.size)
	{
		async thread_task(r, c+1, scoreMatrix, input1, input2, blosum, current_position,A,B);
	}else{
		if((r+1)<=input1.size)
		{
			async thread_task(r+1, c, scoreMatrix, input1, input2, blosum, current_position,A,B);
		}
	}

	var r_inner:Long=r;
    for(var c_inner:Long=c; c_inner>=1; c_inner--){
		// Console.OUT.println("start: "+r+" "+c);
		if(r_inner>input1.size)
		{
			break;// stop loop, finished 
		}
        if(r_inner!=1)
        {
			//TODO row, col limits
            while(current_position(r_inner-1)<c_inner){
				// Console.OUT.println("waiting:"+r_inner+","+c_inner+":"+current_position(r_inner));
			};
        }
		while(current_position(r_inner)<(c_inner-1)){
			// Console.OUT.println("waiting:"+r_inner+","+c_inner+":"+current_position(r_inner));
		}

        var maxScore:Long = 0;
        val maxR:Long = maxRowScore(r_inner,c_inner,scoreMatrix,A,B);
        if(maxR>maxScore){
            maxScore = maxR;
        }
        val maxC:Long = maxColumnScore(r_inner,c_inner,scoreMatrix,A,B);
        if(maxC>maxScore){
            maxScore = maxC;
        }
        val diagnalScore:Long = scoreMatrix(r_inner-1,c_inner-1)+blosum(letterValue.get(input1(r_inner-1)),letterValue.get(input2(c_inner-1)));
        if(diagnalScore>maxScore){
            maxScore = diagnalScore;
        }
        scoreMatrix(r_inner,c_inner) = maxScore;
        atomic {
			if(current_position(r_inner)>=c_inner){
				//pass
			}else{
				current_position(r_inner) = c_inner;
			}
		}
        // Console.OUT.println("point: "+r_inner+" "+c_inner);
        // Console.OUT.println("position: "+r_inner+":"+current_position(r_inner));
		r_inner++;
    }
    return 0;
}

public static def calculate(scoreMatrix: Array_2[Long], input1:Rail[Char],input2:Rail[Char],blosum:Array_2[Long],A:Long,B:Long): Array_2[Long]{
    val current_position = new Array_1[Long](input1.size+1,0);

    // for (var r:Long = 1;r<=input1.size;r++){
        // current_position(r)=0;
    // }

    // var r:Long = 1;
    // finish for (;r<=input1.size;){ // remark: DO NOT r++ here
    // Console.OUT.println(r);
        // async thread_task(r, scoreMatrix, input1, input2, blosum, current_position);        
        // r=r+1;
    // }
    finish thread_task(1, 1, scoreMatrix, input1, input2, blosum, current_position,A,B);        
    return scoreMatrix;
}


   //=================================================================================================

   
   //=================================================================================================

   // find the max value in Row;

   public static def maxRowScore(row: Long, column:Long, scoreMatrix:Array_2[Long],A:Long,B:Long): Long{
	   var maxScore:Long = 0;
	   for (var c:Long = 0;c<column;c++){
		   var tempScore:Long = scoreMatrix(row,c)-penalty(A,B,column-c);
		   if (tempScore>maxScore){
			   maxScore = tempScore;
		   }
	   }
	   
	   return maxScore;
	   
   }

   //=================================================================================================

   //=================================================================================================

   
   

   //=================================================================================================

   // find the max value in Column;

   public static def maxColumnScore(row: Long, column:Long, scoreMatrix:Array_2[Long],A:Long,B:Long): Long{
	   var maxScore:Long = 0;
	   for (var r:Long = 0;r<row;r++){
		   var tempScore:Long = scoreMatrix(r,column)-penalty(A,B,row-r);
		   if (tempScore>maxScore){
			   maxScore = tempScore;
		   }
	   }
   
	   
	   return maxScore;
	   
   }

   //=================================================================================================
   
   

   //=================================================================================================

   // Find the max score value and its position







   //=================================================================================================

   

   

   

   //=================================================================================================

   // traceback;

   public static def traceback(scoreMatrix: Array_2[Long], input1:Rail[Char], input2:Rail[Char], blosum:Array_2[Long]): Rail[Rail[Long]] {
	   var bestScore:Long = 0;
	   val bestCoordinate:Rail[Long] = new Rail[Long](2);
	   
	   val resultList = new ArrayList[Rail[Long]]();
	   //bestCoordinate(0) is row, bestCoordinate(1) is column;
	   for (var r:Long = 1;r<=input1.size;r++){
		   for(var c:Long = 1; c<=input2.size; c++){
			   if(scoreMatrix(r,c) > bestScore){
				   bestScore = scoreMatrix(r,c);
				   bestCoordinate(0) = r;
				   bestCoordinate(1) = c;
			   }
		   }
	   }	
	   var curRow:Long = bestCoordinate(0);
	   var curColumn:Long = bestCoordinate(1);
	   val curCoordinate:Rail[Long] = new Rail[Long](2);
	   curCoordinate(0) = curRow;
	   curCoordinate(1) = curColumn;
	   // start to find the route;

	   while(true){
		   if (curRow!=0 && curColumn!=0){
			   val midResult = new Rail[Long](2);
			   midResult(0) = curRow;
			   midResult(1) = curColumn;
			   resultList.add(midResult);
			   var tempColumn:Long = curColumn-1;
			   var tempRow:Long = curRow;
			   var BestScore:Long = scoreMatrix(curRow,curColumn-1);
			   // val upScore:Long = scoreMatrix(curRow,curColumn-1);
			   val leftScore:Long = scoreMatrix(curRow-1,curColumn);
			   if(leftScore>BestScore){
				   BestScore = leftScore;
				   tempRow = curRow-1;
				   tempColumn = curColumn;
			   }
			   val leftupScore:Long = scoreMatrix(curRow-1,curColumn-1);
			   if(leftupScore>BestScore){
				   BestScore = leftupScore;
				   tempRow = curRow-1;
				   tempColumn = curColumn-1;
			   }
			   curRow = tempRow;
			   curColumn = tempColumn;
			   //check if the best score is 0;
			   if(bestScore == 0){
				   midResult(0) = curRow;
				   midResult(1) = curColumn;
				   if(curRow!=0 && curColumn!=0){
					   resultList.add(midResult);
				   }
				   break;
			   }
		   }
		   else{
			   break;
		   }
	   }
	   
	   
	   val finalResult:Rail[Rail[Long]] = new Rail[Rail[Long]](resultList.size());
	   for(var i:Long = resultList.size()-1; i>=0;i--){
		   finalResult(resultList.size()-1-i) = resultList.get(i);
	   }
	   
	   printResult(finalResult,input1,input2,bestScore);
	   
	   return finalResult;
          

   }

   //=================================================================================================

   

   

   

   

   //=================================================================================================

   // Print Result

   public static def printResult(seq:Rail[Rail[Long]],input1:Rail[Char],input2:Rail[Char], maxScore:Long): void{
	   val totalLength:Float = seq.size;
	   var Gaps:Float = 0;
	   var identity:Float = 0;
	   val output1 = new ArrayList[Char]();
	   val output2 = new ArrayList[Char]();
	   var lastRow:Long = seq(0)(0);
	   var lastColumn:Long = seq(0)(1);
	   
	   // add the start point to the list;
	   output1.add(input1(lastRow-1));
	   output2.add(input2(lastColumn-1));
	   if (input1(lastRow-1).equals(input2(lastColumn-1))){
		   identity++;
	   }
	   
	   for(var i:Long = 1; i<totalLength;i++){
		   val coor:Rail[Long] = seq(i);
		   val row:Long = coor(0);
		   val column:Long = coor(1);
		   if((row - lastRow) == 0){
			   output1.add('-');
			   output2.add(input2(column-1));
			   Gaps++;
		   }
		   else if((column - lastColumn) == 0){
			   output2.add('-');
			   output1.add(input1(row-1));
			   Gaps++;
		   }
		   else if((row - lastRow) == 1 && (column - lastColumn) ==1){
			   output1.add(input1(row-1));
			   output2.add(input2(column-1));
		   }
		   lastRow = row;
		   lastColumn = column;
		   if (input1(lastRow-1).equals(input2(lastColumn-1))){
			   identity++;
		   }
	   }
	   
	   
	   
	   Console.OUT.println("Identity: "+identity+"/"+ totalLength + " (" + (identity/totalLength)*100 + "%)"); 
	   Console.OUT.println("Gaps: "+Gaps+"/"+ totalLength + " (" + (Gaps/totalLength)*100 + "%)"); 
	   Console.OUT.println("Score: "+maxScore); 
	   Console.OUT.print("1: "); 
	   for(var i:Long = 0; i<output1.size();i++){
		   Console.OUT.print(output1.get(i)); 
	   }
	   Console.OUT.print("\n");
	   
	   Console.OUT.print("2: "); 
	   for(var i:Long = 0; i<output2.size();i++){
		   Console.OUT.print(output2.get(i)); 
	   }
	   Console.OUT.print("\n");

   }

   //=================================================================================================

   

   

   

   

   

   //=================================================================================================

   //main function

    public static def main(args: Rail[String]) {
    //AF043946.1 AF043947.1 BLOSUM62 10 5
    val input1:String = args(0);
    val input2:String = args(1);
    val blosumFile:String = args(2);
    val A:Long = Long.parse(args(3));
    val B:Long = Long.parse(args(4));

    val date1 = new Date();
    
    val starttime = date1.getTime();
    
    val charList1:Rail[Char] = parseInput(input1);

    val charList2:Rail[Char] = parseInput(input2);

    //Console.OUT.println("first input: "+ charList1.toString());  

    //Console.OUT.println("second input: "+charList2.toString()); 

    val blosum = buildBlosum(blosumFile);

    //Console.OUT.println("blosum: "+blosum.toString()); 

    val n:Long = charList1.size + 1; // the row length of score matrix;

    val m:Long = charList2.size + 1; // the column length of score matrix;

    val scoreMatrix = new Array_2[Long](n, m, 0); // build a n x m matrix and initialize everything to 0, no need to initialize the first row and column;

    calculate(scoreMatrix,charList1,charList2,blosum,A,B); // calculate the score matrix

    val sequence:Rail[Rail[Long]] = traceback(scoreMatrix,charList1,charList2,blosum); // trace back and give out the sequence;

    val date2 = new Date();
    val endtime = date2.getTime();
    
    Console.OUT.println("Running Time: "+(endtime-starttime) +"  milliseconds."); 
    

    

    	

    }

}
