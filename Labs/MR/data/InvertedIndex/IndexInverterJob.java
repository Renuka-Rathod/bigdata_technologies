package inverted;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class IndexInverterJob extends Configured implements Tool {

	public static class IndexInverterMapper extends
			Mapper<LongWritable, Text, Text, Text> {

		private Text outputKey = new Text();
		private Text outputValue = new Text();
		
		//TODO
		@Override
		protected void map(LongWritable key, _____ value, Context context)
				throws IOException, InterruptedException {
			String [] words = value.toString().split(",");
			outputValue.set(words[0]);
			for(int i = 1; i < words.length; i++) {
				outputKey.set(words[i]);
				context.write(outputKey, outputValue);
			}
		}
	}
	
	//TODO
	public static class IndexInverterReducer extends
			Reducer<_____, _____, Text, Text> {
		private Text outputValue = new Text();
		
		//TODO
		@Override
		protected void reduce(Text key, _____ values, Context context)
				throws IOException, InterruptedException {
			StringBuilder builder = new StringBuilder();
			for(Text value: values) {
				builder.append(value.toString()).append(",");
			}
			builder.deleteCharAt(builder.length() - 1);
			outputValue.set(builder.toString());
			context.write(key, outputValue);
		}
		
	}	
	
	@Override
	public int run(String[] args) throws Exception {
		Configuration conf = super.getConf();
		Job job = Job.getInstance(conf, "IndexInverterJob");
		job.setJarByClass(IndexInverterJob.class);

		Path in = new Path(args[0]);
		Path out = new Path(args[1]);
		out.getFileSystem(conf).delete(out, true);
		FileInputFormat.setInputPaths(job, in);
		FileOutputFormat.setOutputPath(job,  out);
		
		//TODO
		job.setMapperClass(_________);
		//TODO
		job.setReducerClass(__________);

		job.setInputFormatClass(TextInputFormat.class);
		job.setOutputFormatClass(TextOutputFormat.class);

		//TODO
		job.setMapOutputKeyClass(________);
		job.setMapOutputValueClass(Text.class);
		//TODO
		job.setOutputKeyClass(__________);
		job.setOutputValueClass(Text.class);
		
		return job.waitForCompletion(true)?0:1;
	}

	public static void main(String[] args) {
		int result;
		try {
			//TODO
			result = ToolRunner.run(new Configuration(),  
			        new _____, args);
			System.exit(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

//Use following command to run the application
//$>	yarn jar invertedindex.jar <Main class> inverted/ inverted/output