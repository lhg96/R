package r;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

/**
 * [출처] Java 와 R 연동하기, 간단한 예제. 이클립스 ( Eclipse ) [소스코드]|작성자 티 타임 20200824
 * 
 * 정상작동 버젼
 * https://niceguy1575.tistory.com/entry/%ED%8C%8C%EC%9D%BC%EC%A0%84%EC%86%A1-%EC%8B%9C%EC%8A%A4%ED%85%9C-4-JAVA-R-%EC%97%B0%EA%B2%B0-%EB%B0%8F-%ED%86%B5%EA%B3%84%EB%B6%84%EC%84%9D-%EC%84%9C%EB%B2%84-%EA%B5%AC%EC%B6%95-1
 * @author USER
 *
 */
public class Test01 {
	/*
	 * public static void main(String[] args) {
	 * 
	 * RConnection connection = null;
	 * 
	 * try {
	 * 
	 * connection = new RConnection();
	 * 
	 * String vector = "c(1,2,3,4)"; connection.eval("meanVal=mean(" + vector +
	 * ")"); double mean = connection.eval("meanVal").asDouble();
	 * System.out.println("The mean of given vector is=" + mean);
	 * connection.eval("aa <- '한글'");
	 * System.out.println(connection.eval("aa").asString());
	 * 
	 * connection.close(); } catch (RserveException e) { e.printStackTrace(); }
	 * catch (REXPMismatchException e) { e.printStackTrace(); } finally {
	 * connection.close(); } }
	 */
	/*
	public static void main(String[] args) throws RserveException, REXPMismatchException {
		try {
			RConnection c = new RConnection();// make a new local connection on default port (6311)
			double d[] = c.eval("rnorm(10)").asDoubles();
			org.rosuda.REngine.REXP x0 = c.eval("R.version.string");
			System.out.println(x0.asString());
		} catch (REngineException e) {
			// manipulation
		}

	}*/
	private RConnection c = null;
	
	public Test01() throws RserveException {
		c = new RConnection();
	}
	
	public void getRVersion() throws RserveException, REXPMismatchException {
		REXP x = c.eval("R.version.string");
		System.out.println("R version:"+x.asString());		
	}
	private void getDoubles() throws RserveException {
		REXP  x= c.eval("rnorm(100)");
	}
	
	
	
	public static void main(String[] args) throws RserveException, REXPMismatchException {
		Test01  test = new Test01();
		test.getRVersion();
	}

}
